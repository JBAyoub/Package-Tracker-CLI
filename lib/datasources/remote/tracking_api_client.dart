import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TrackingApiClient {
  Future<Map<String, dynamic>?> get17TrackData(
    String? key,
    String? trackNumber,
    String? carrier,
  ) async {
    if (carrier == null) {
      return null;
    }
    final uri = Uri.https("api.17track.net", '/track/v2.4/gettrackinfo');
    final response = await http.post(
      uri,
      headers: {'17token': key!.trim(), 'Content-Type': 'application/json'},
      body: jsonEncode([
        {'number': trackNumber, 'carrier': carrier},
      ]),
    );

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  Future<String?> registerTrackingNumbers({
    // ignore: non_constant_identifier_names
    required String? APIkey,
    required String? trackingNumber,
  }) async {
    final uri = Uri.https('api.17track.net', '/track/v2.4/register');

    final response = await http.post(
      uri,
      headers: {'17token': APIkey!.trim(), 'Content-Type': 'application/json'},
      body: jsonEncode([
        {'number': trackingNumber},
      ]),
    );
    return getCarrier(response);
  }

  String? getCarrier(http.Response response) {
    if (response.statusCode != 200) {
      return null;
    }

    final decoded = jsonDecode(response.body);

    if (decoded["code"] == 500) {
      return null;
    }

    final accepted = decoded["data"]["accepted"] as List;
    final rejected = decoded["data"]["rejected"] as List;

    if (accepted.isNotEmpty) {
      return accepted.first["carrier"].toString();
    }

    if (rejected.isNotEmpty) {
      return rejected.first["carrier"].toString();
    }

    return null;
  }
}

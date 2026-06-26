// ignore: file_names
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:package__tracker__c_l_i/Models/Parcel.dart';

Future<void> getTrackInfo({
  required String trackNumber,
  required String key,
}) async {
  String? carrier = await registerTrackingNumbers(
    APIkey: key,
    trackingNumber: trackNumber,
  );
  if (carrier == null) {
    print("Could not find the carrier info");
    return;
  } else {
    final uri = Uri.https("api.17track.net", '/track/v2.4/gettrackinfo');
    final response = await http.post(
      uri,
      headers: {'17token': key.trim(), 'Content-Type': 'application/json'},
      body: jsonEncode([
        {'number': trackNumber, 'carrier': carrier},
      ]),
    );
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var p = Parcel.fromJson(jsonResponse);
      print(p);
    } else {
      print(
        "Could not find package :( \n Please check the tracking number and try again.",
      );
    }
    return;
  }
}

Future<String?> registerTrackingNumbers({
  // ignore: non_constant_identifier_names
  required String APIkey,
  required String trackingNumber,
}) async {
  final uri = Uri.https('api.17track.net', '/track/v2.4/register');

  final response = await http.post(
    uri,
    headers: {'17token': APIkey.trim(), 'Content-Type': 'application/json'},
    body: jsonEncode([
      {'number': trackingNumber},
    ]),
  );
  return getCarrier(response);
}

String? getCarrier(http.Response response) {
  if (response.statusCode == 200) {
    final String? carrier;
    final decoded = jsonDecode(response.body);
    final accepted = decoded["data"]["accepted"] as List;
    final rejected = decoded["data"]["rejected"] as List;
    if (accepted.isNotEmpty) {
      carrier = accepted[0]["carrier"].toString();
      return carrier;
    } else if (rejected.isNotEmpty) {
      carrier = rejected[0]["carrier"].toString();
      return carrier;
    }
  }
  print("Could not get the carrier.");
  return null;
}

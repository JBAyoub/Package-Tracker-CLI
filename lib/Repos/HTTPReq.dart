// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> registerTrackingNumbers({
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

  print('Status: ${response.statusCode}');
  print(response.body);
}

// ignore: file_names
class Parcel {
  final String trackingNumber;
  final String carrier;
  final String status;
  final String from;
  final String to;
  // final Map<DateTime?, String?> history;
  // final Map<String, dynamic> shipmentDetails;

  Parcel({
    required this.trackingNumber,
    required this.carrier,
    required this.status,
    required this.from,
    required this.to,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    final parcel = json['data']['accepted'][0];
    final info = parcel['track_info'];

    return Parcel(
      trackingNumber: parcel['number'],
      carrier: parcel['provider']['name'],
      status: info['latest_event']['description'],
      from: info['shipping_info']['shipper_address']['country'],
      to: info['shipping_info']['recipient_address']['country'],
    );
  }

  @override
  String toString() {
    return '''
==================================================
PACKAGE TRACKER
==================================================

Tracking Number : $trackingNumber
Carrier         : $carrier
Status          : $status
From            : $from
To              : $to

Latest Update:

''';
  }
}

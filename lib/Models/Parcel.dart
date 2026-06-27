// ignore: file_names
import 'package:package__tracker__c_l_i/Models/ShipmentDetails.dart';
import 'package:package__tracker__c_l_i/Models/TrackingEvent.dart';

class Parcel {
  final String trackingNumber;
  final String carrier;
  final String status;
  final String from;
  final String to;
  final List<TrackingEvent> history;
  final Shipmentdetails shipmentDetails;

  Parcel({
    required this.trackingNumber,
    required this.carrier,
    required this.status,
    required this.from,
    required this.to,
    required this.history,
    required this.shipmentDetails,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    final parcel = json['data']['accepted'][0] ?? '';
    final info = parcel['track_info'];
    return Parcel(
      trackingNumber: parcel['number'],
      carrier: info['tracking']['providers'][0]['provider']['name'],
      status:
          info['latest_event']?['description']?.toString() ??
          info['latest_status']?['status']?.toString() ??
          'Unknown',
      from: info['shipping_info']['shipper_address']['country'],
      to: info['shipping_info']['recipient_address']['country'],
      history: (info["milestone"] as List)
          .map((event) => TrackingEvent.fromJson(event))
          .toList(),
      shipmentDetails: Shipmentdetails.fromJson(
        parcel["track_info"]["misc_info"] as Map<String, dynamic>,
      ),
    );
  }

  @override
  String toString() {
    final historyText = history.map((event) => event.toString()).join('\n');
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
${history.isNotEmpty ? history.first : 'No tracking events available.'}
==================================================
History
==================================================
$historyText
$shipmentDetails

''';
  }
}

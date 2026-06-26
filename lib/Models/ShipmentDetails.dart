class Shipmentdetails {
  final String? service;
  final double? weight;
  final String? dimensions;
  final int? pieces;

  const Shipmentdetails({
    required this.service,
    required this.weight,
    required this.dimensions,
    required this.pieces,
  });

  factory Shipmentdetails.fromJson(Map<String, dynamic> json) {
    return Shipmentdetails(
      service: json['service_type'] ?? "",
      weight: double.tryParse(json['weight_kg'].toString()) ?? 0.0,
      dimensions: json['dimensions'].toString(),
      pieces: int.tryParse(json['pieces'].toString()),
    );
  }

  @override
  String toString() {
    return '''
==================================================
Shipment Details
==================================================

Service  : $service
Weight   : $weight
Status   : $dimensions
Pieces   : $pieces

''';
  }
}

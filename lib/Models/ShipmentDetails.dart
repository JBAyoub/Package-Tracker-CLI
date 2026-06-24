class Shipmentdetails {
  final String? service;
  final double? weight;
  final Set<double>? dimensions;
  final int? pieces;

  const Shipmentdetails({
    required this.service,
    required this.weight,
    required this.dimensions,
    required this.pieces,
  });

  static Set<double>? parseWeight(String? weight) {
    if (weight == null || weight.isEmpty) {
      print("No dimensions were found from the server response :( ");
      return null;
    } else {
      final Set<double> dimensions = {};

      List<String> slices = weight.replaceAll(" CM", "").split("*");
      final length = double.parse(slices[0]);
      final width = double.parse(slices[1]);
      final height = double.parse(slices[2]);
      dimensions.addAll([length, width, height]);
      return dimensions;
    }
  }

  factory Shipmentdetails.fromJson(Map<String, dynamic> json) {
    return Shipmentdetails(
      service: json['service_type'] ?? "",
      weight: double.tryParse(json['weight_kg']) ?? 0.0,
      dimensions: parseWeight(json['dimensions']),
      pieces: int.tryParse(json['pieces']),
    );
  }
}

class TrackingEvent {
  final DateTime? time;
  final String? description;
  final String? location;

  const TrackingEvent({
    required this.time,
    required this.description,
    this.location,
  });

  factory TrackingEvent.fromJson(Map<String, dynamic> json) {
    return TrackingEvent(
      time: DateTime.tryParse(json["time_raw"]["date"].toString()),
      description: json["key_stage"] ?? 'No description found',
      location: json["location"] ?? 'No location found',
    );
  }
  @override
  String toString() {
    return '''
==================================================
Event
==================================================

Time        : ${time?.toIso8601String() ?? 'Unknown'}
Description : ${description ?? 'Unknown'}
Location    : ${location ?? 'Unknown'}


''';
  }
}

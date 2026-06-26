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
      time: json["time_iso"],
      description: json["key_stage"],
      location: json["location"],
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

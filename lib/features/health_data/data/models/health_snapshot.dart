class HealthSnapshot {
  const HealthSnapshot({
    required this.date,
    required this.steps,
    required this.distanceMeters,
    required this.syncedAt,
  });

  factory HealthSnapshot.fromJson(Map<String, dynamic> json) => HealthSnapshot(
    date: DateTime.parse(json['date'] as String),
    steps: json['steps'] as int,
    distanceMeters: (json['distanceMeters'] as num).toDouble(),
    syncedAt: DateTime.parse(json['syncedAt'] as String),
  );

  final DateTime date; // hangi güne ait
  final int steps;
  final double distanceMeters;
  final DateTime syncedAt; // cihazdan ne zaman çekildi

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'steps': steps,
    'distanceMeters': distanceMeters,
    'syncedAt': syncedAt.toIso8601String(),
  };
}

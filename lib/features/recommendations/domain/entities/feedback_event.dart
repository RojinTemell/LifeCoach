import 'package:life_coach/features/recommendations/domain/entities/recommendation_feedback.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

class FeedbackEvent {
  const FeedbackEvent({
    required this.type,
    required this.feedback,
    required this.at,
  });

  factory FeedbackEvent.fromJson(Map<String, dynamic> json) => FeedbackEvent(
    type: RecommendationType.values.byName(json['type'] as String),
    feedback: RecommendationFeedback.values.byName(json['feedback'] as String),
    at: DateTime.parse(json['at'] as String),
  );

  final RecommendationType type;
  final RecommendationFeedback feedback;
  final DateTime at;

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'feedback': feedback.name,
    'at': at.toIso8601String(),
  };
}

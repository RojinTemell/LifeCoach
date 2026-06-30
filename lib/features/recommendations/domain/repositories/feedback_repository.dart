import 'package:life_coach/features/recommendations/domain/entities/feedback_event.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_feedback.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

abstract interface class FeedbackRepository {
  Future<void> record({
    required RecommendationType type,
    required RecommendationFeedback feedback,
    required DateTime at,
  });
  Future<List<FeedbackEvent>> getAll();
}

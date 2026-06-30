import 'package:injectable/injectable.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_feedback.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/repositories/feedback_repository.dart';

@lazySingleton
class RecordFeedbackUseCase {
  RecordFeedbackUseCase(this._repository);

  final FeedbackRepository _repository;

  Future<void> call({
    required RecommendationType type,
    required RecommendationFeedback feedback,
  }) {
    return _repository.record(
      type: type,
      feedback: feedback,
      at: DateTime.now(),
    );
  }
}

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier.dart';
import 'package:life_coach/features/onboarding/domain/repositories/user_preferences_repository.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_feedback.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/usecases/generate_recommendations_usecase.dart';
import 'package:life_coach/features/recommendations/domain/usecases/record_feedback_usecase.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_state.dart';

// injectable çünkü Cubit her ekran açılışında yeni olmalı
@injectable
class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit(
    this._generateRecommendations,
    this._notifier,
    this._prefs,
    this._recordFeedback,
  ) : super(const RecommendationsState());
  final GenerateRecommendationsUseCase _generateRecommendations;
  final RecommendationNotifier _notifier;
  final UserPreferencesRepository _prefs;
  final RecordFeedbackUseCase _recordFeedback;

  Future<void> load() async {
    emit(state.copyWith(status: RecommendationsStatus.loading));
    final goal = await _prefs.getGoal() ?? UserGoal.moreMovement;
    final profile = await _prefs.getProfile();
    final result = await _generateRecommendations.call(
      goal: goal,
      profile: profile,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RecommendationsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (recs) {
        emit(
          state.copyWith(
            status: RecommendationsStatus.success,
            recommendations: recs,
          ),
        );
        unawaited(_notifier.notify(recs));
      },
    );
  }

  void recordFeedback(Recommendation rec, RecommendationFeedback feedback) {
    unawaited(
      _recordFeedback(type: rec.type, feedback: feedback),
    ); // kaydet (fire-forget)
    emit(
      state.copyWith(
        recommendations: state.recommendations.where((r) => r != rec).toList(),
      ),
    ); // kartı listeden kaldır (anlık geri bildirim)
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/services/notifications/notification_service.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/usecases/generate_recommendations_usecase.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_state.dart';

// injectable çünkü Cubit her ekran açılışında yeni olmalı
@injectable
class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit(this._generateRecommendations, this._notifications)
    : super(const RecommendationsState());
  final GenerateRecommendationsUseCase _generateRecommendations;
  final NotificationService _notifications;

  Future<void> load({required UserGoal goal}) async {
    emit(state.copyWith(status: RecommendationsStatus.loading));
    final result = await _generateRecommendations.call(goal: goal);
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
        _notifyTop(recs);
      },
    );
  }

  void _notifyTop(List<Recommendation> recs) {
    if (recs.isEmpty) return;
    final top = recs.first; // engine zaten önceliğe göre sıralıyor
    unawaited(
      _notifications.show(
        id: top.type.index, // tip başına sabit id → aynı tip üst üste birikmez
        title: 'Yaşam Koçu',
        body: top.message,
        payload: AppRoutes.dashboard, // tıklayınca buraya gidicek
      ),
    );
  }
}

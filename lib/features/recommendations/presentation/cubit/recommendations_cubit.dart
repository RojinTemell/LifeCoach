import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/usecases/generate_recommendations_usecase.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_state.dart';

class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit(this._generateRecommendations)
    : super(const RecommendationsState());
  final GenerateRecommendationsUseCase _generateRecommendations;

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
      (recs) => emit(
        state.copyWith(
          status: RecommendationsStatus.success,
          recommendations: recs,
        ),
      ),
    );
  }
}

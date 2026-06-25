import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:life_coach/core/error/failures.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';
import 'package:life_coach/features/recommendations/domain/engine/recommendation_engine.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/services/user_context_builder.dart';
import 'package:life_coach/features/recommendations/domain/usecases/generate_recommendations_usecase.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_cubit.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_state.dart';

class _FakeHealthRepo implements HealthRepository {
  _FakeHealthRepo({this.fail = false});
  final bool fail;
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<Either<Failure, int>> getTodaySteps() async =>
      fail ? const Left(HealthDataFailure()) : const Right(500);
  @override
  Future<Either<Failure, double>> getTodayDistance() async => const Right(0);
}

class _StubEngine implements RecommendationEngine {
  _StubEngine(this.recs);
  final List<Recommendation> recs;
  @override
  Future<List<Recommendation>> generate(UserContext context) async => recs;
}

GenerateRecommendationsUseCase _useCase({
  bool fail = false,
  List<Recommendation> recs = const [],
}) => GenerateRecommendationsUseCase(
  UserContextBuilder(_FakeHealthRepo(fail: fail)),
  _StubEngine(recs),
);

void main() {
  test('load: başarılıysa success + öneriler', () async {
    final cubit = RecommendationsCubit(
      _useCase(
        recs: const [
          Recommendation(
            type: RecommendationType.movement,
            message: 'yürü',
            priority: 3,
          ),
        ],
      ),
    );
    await cubit.load(goal: UserGoal.moreMovement);
    expect(cubit.state.status, RecommendationsStatus.success);
    expect(cubit.state.recommendations.length, 1);
  });
  test('load: health başarısızsa failure', () async {
    final cubit = RecommendationsCubit(_useCase(fail: true));

    await cubit.load(goal: UserGoal.moreMovement);

    expect(cubit.state.status, RecommendationsStatus.failure);
  });
}

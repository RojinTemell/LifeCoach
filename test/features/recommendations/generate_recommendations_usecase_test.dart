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

void main() {
  test('context kurulur, engine çalışır, öneriler döner', () async {
    final useCase = GenerateRecommendationsUseCase(
      UserContextBuilder(_FakeHealthRepo()),
      _StubEngine(const [
        Recommendation(
          type: RecommendationType.movement,
          message: 'yürü',
          priority: 3,
        ),
      ]),
    );
    final result = await useCase(goal: UserGoal.moreMovement);
    final recs = result.getOrElse((_) => const []);
    expect(recs.length, 1);
  });
  test('health başarısızsa Failure döner', () async {
    final useCase = GenerateRecommendationsUseCase(
      UserContextBuilder(_FakeHealthRepo(fail: true)),
      _StubEngine(const []),
    );

    final result = await useCase(goal: UserGoal.moreMovement);

    expect(result.isLeft(), true);
  });
}

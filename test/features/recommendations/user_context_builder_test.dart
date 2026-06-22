import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:life_coach/core/error/failures.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/services/user_context_builder.dart';

class _FakeHealthRepo implements HealthRepository {
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<Either<Failure, int>> getTodaySteps() async => const Right(4200);
  @override
  Future<Either<Failure, double>> getTodayDistance() async => const Right(3100);
}

class _FailingHealthRepo implements HealthRepository {
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<Either<Failure, int>> getTodaySteps() async =>
      const Left(HealthDataFailure());
  @override
  Future<Either<Failure, double>> getTodayDistance() async => const Right(0);
}

void main() {
  test('sağlık verisi + hedef → UserContext kurar', () async {
    final builder = UserContextBuilder(_FakeHealthRepo());

    final result = await builder.build(
      goal: UserGoal.moreMovement,
      date: DateTime(2026, 6, 21, 14, 30),
    );

    final ctx = result.getOrElse((_) => throw StateError('beklenmedik hata'));
    expect(ctx.steps, 4200);
    expect(ctx.distanceMeters, 3100);
    expect(ctx.goal, UserGoal.moreMovement);
    expect(ctx.timestamp.hour, 14);
  });

  test('sağlık verisi başarısızsa Failure taşır', () async {
    final builder = UserContextBuilder(_FailingHealthRepo());

    final result = await builder.build(goal: UserGoal.moreMovement);

    expect(result.isLeft(), true);
  });
}

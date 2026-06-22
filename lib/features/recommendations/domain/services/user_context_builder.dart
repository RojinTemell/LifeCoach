import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/core/error/failures.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';

@injectable
class UserContextBuilder {
  UserContextBuilder(this._healthRepository);

  final HealthRepository _healthRepository;
  Future<Either<Failure, UserContext>> build({
    required UserGoal goal,
    DateTime? date,
  }) async {
    final stepsResult = await _healthRepository.getTodaySteps();
    final distanceResult = await _healthRepository.getTodayDistance();
    // aslında if else yaoısnın kısa yolu (flatmap)
    return stepsResult.flatMap(
      (steps) => distanceResult.map(
        (distance) => UserContext(
          timestamp: date ?? DateTime.now(),
          steps: steps,
          distanceMeters: distance,
          goal: goal,
        ),
      ),
    );
  }
}

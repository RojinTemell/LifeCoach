import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/core/error/failures.dart';
import 'package:life_coach/features/onboarding/domain/entities/user_profile.dart';
import 'package:life_coach/features/recommendations/domain/engine/recommendation_engine.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/services/user_context_builder.dart';

@lazySingleton
class GenerateRecommendationsUseCase {
  GenerateRecommendationsUseCase(this._contextBuilder, this._engine);

  final UserContextBuilder _contextBuilder;
  final RecommendationEngine _engine;

  Future<Either<Failure, List<Recommendation>>> call({
    required UserGoal goal,
    UserProfile? profile,
  }) async {
    final contextResult = await _contextBuilder.build(
      goal: goal,
      profile: profile,
    );

    return contextResult.fold(
      (failure) async => Left(failure),
      (context) async => Right(await _engine.generate(context)),
    );
  }
}

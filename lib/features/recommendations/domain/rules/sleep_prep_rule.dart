import 'package:injectable/injectable.dart';
import 'package:life_coach/features/recommendations/domain/engine/rule.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';

@lazySingleton
class SleepPrepRule implements Rule {
  static const _eveningHour = 22;
  static const _earlyEveningHour = 21;

  @override
  bool isApplicable(UserContext context) {
    final hour = context.timestamp.hour;
    final wantsBetterSleep = context.goal == UserGoal.betterSleep;
    return hour >= _eveningHour ||
        (wantsBetterSleep && hour >= _earlyEveningHour);
  }

  @override
  Recommendation build(UserContext context) {
    final priority = context.goal == UserGoal.betterSleep ? 5 : 3;
    return Recommendation(
      type: RecommendationType.sleepPrep,
      message: 'Akşam oldu. Ekranı azaltıp uykuya hazırlanmaya ne dersin?',
      priority: priority,
    );
  }
}

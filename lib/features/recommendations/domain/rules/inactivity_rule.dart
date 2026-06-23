import 'package:life_coach/features/recommendations/domain/engine/rule.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';

class InactivityRule implements Rule {
  static const _activeStartHour = 8;
  static const _activeEndHour = 22;
  static const _lowStepThreshold = 2000;
  @override
  Recommendation build(UserContext context) {
    return const Recommendation(
      type: RecommendationType.movement,
      message:
          'Bugün biraz hareketsiz kaldın. '
          '10 dakikalık kısa bir yürüyüşe ne dersin?',
      priority: 3,
    );
  }

  @override
  bool isApplicable(UserContext context) {
    final hour = context.timestamp.hour;
    final isActiveHour = hour >= _activeStartHour && hour < _activeEndHour;
    return isActiveHour && context.steps < _lowStepThreshold;
  }
}

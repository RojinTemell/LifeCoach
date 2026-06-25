import 'package:life_coach/features/recommendations/domain/engine/rule.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';

class BreakStretchRule implements Rule {
  static const _workStartHour = 9;
  static const _workEndHour = 18;
  @override
  bool isApplicable(UserContext context) {
    final hour = context.timestamp.hour;
    return hour >= _workStartHour && hour <= _workEndHour;
  }

  @override
  Recommendation build(UserContext context) {
    return const Recommendation(
      type: RecommendationType.breakStretch,
      message: 'Çalışma saatlerindesin. Kısa bir esneme molası iyi gelebilir.',
      priority: 2,
    );
  }
}

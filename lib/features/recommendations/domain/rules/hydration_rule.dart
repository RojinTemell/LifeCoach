import 'package:injectable/injectable.dart';
import 'package:life_coach/features/recommendations/domain/engine/rule.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';

@lazySingleton
class HydrationRule implements Rule {
  static const _wakingStartHour = 8;
  static const _wakingEndHour = 22;

  @override
  bool isApplicable(UserContext context) {
    final hour = context.timestamp.hour;
    return hour >= _wakingStartHour && hour <= _wakingEndHour;
  }

  @override
  Recommendation build(UserContext context) {
    return const Recommendation(
      type: RecommendationType.hydration,
      message:
          'Bir bardak su içmeye ne dersin? '
          'Gün içinde düzenli su içmek enerjini korur.',
      priority: 1,
    );
  }
}

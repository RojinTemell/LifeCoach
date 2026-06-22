import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';

abstract interface class Rule {
  /// Bu kural verilen bağlamda geçerli mi? (örn. "2 saattir hareketsiz mi?")
  bool isApplicable(UserContext context);

  /// Geçerliyse, üreteceği öneri.
  Recommendation build(UserContext context);
}

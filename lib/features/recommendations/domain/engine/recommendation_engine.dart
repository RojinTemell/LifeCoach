import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';

// Kasıtlı polimorfik sözleşme: RuleBasedEngine (MVP) ve ileride
// AiRecommendationEngine, DI ile takas edilir. Fonksiyona indirgenemez.
// ignore: one_member_abstracts
abstract interface class RecommendationEngine {
  Future<List<Recommendation>> generate(UserContext context);
}

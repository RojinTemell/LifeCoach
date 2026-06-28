import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';

// Kasıtlı seam: DI ile takılır, testlerde fake'lenir, ileride
// (rate-limit, farklı kanal) genişler. Fonksiyona indirgenemez.
// ignore: one_member_abstracts
abstract interface class RecommendationNotifier {
  Future<void> notify(List<Recommendation> recommendations);
}

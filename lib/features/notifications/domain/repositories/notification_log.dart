import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

abstract interface class NotificationLog {
  Future<DateTime?> lastShownAt(RecommendationType type);
  Future<int> countToday();
  Future<void> record(RecommendationType type, DateTime at);
}

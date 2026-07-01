import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

abstract interface class NotificationPreferencesRepository {
  Future<bool> isEnabled(RecommendationType type);
  Future<void> setEnabled(RecommendationType type, {required bool enabled});
}

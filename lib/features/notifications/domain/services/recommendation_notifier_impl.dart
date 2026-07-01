import 'package:injectable/injectable.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/services/notifications/notification_service.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_log.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_preferences_repository.dart';
import 'package:life_coach/features/notifications/domain/repositories/quiet_hours_repository.dart';
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';

@LazySingleton(as: RecommendationNotifier)
class RecommendationNotifierImpl implements RecommendationNotifier {
  RecommendationNotifierImpl(
    this._notifications,
    this._quietHours,
    this._log,
    this._preferences,
  );

  final NotificationService _notifications;
  final QuietHoursRepository _quietHours;
  final NotificationLog _log;
  final NotificationPreferencesRepository _preferences;

  static const _dailyMax = 4;
  static const _minInterval = Duration(minutes: 90);

  @override
  Future<void> notify(List<Recommendation> recommendations) async {
    if (recommendations.isEmpty) return;

    final now = DateTime.now();

    if ((await _quietHours.get()).isQuietAt(now)) return; // sessiz saat
    if (await _log.countToday() >= _dailyMax) return; // günlük maks

    for (final rec in recommendations) {
      if (!(await _preferences.isEnabled(rec.type))) continue; // opt-out
      final last = await _log.lastShownAt(rec.type);
      if (last != null && now.difference(last) < _minInterval) {
        continue; // dedup
      }

      await _notifications.show(
        id: rec.type.index,
        title: 'Yaşam Koçu',
        body: rec.message,
        payload: AppRoutes.dashboard,
      );
      await _log.record(rec.type, now);
      return; // tek bildirim yeter
    }
  }
}

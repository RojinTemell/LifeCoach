import 'package:injectable/injectable.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/services/notifications/notification_service.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_log.dart';
import 'package:life_coach/features/notifications/domain/repositories/quiet_hours_repository.dart';
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';

@LazySingleton(as: RecommendationNotifier)
class RecommendationNotifierImpl implements RecommendationNotifier {
  RecommendationNotifierImpl(this._notifications, this._quietHours, this._log);

  final NotificationService _notifications;
  final QuietHoursRepository _quietHours;
  final NotificationLog _log;

  static const _dailyMax = 4;
  static const _minInterval = Duration(minutes: 90);

  @override
  Future<void> notify(List<Recommendation> recommendations) async {
    if (recommendations.isEmpty) return;
    final now = DateTime.now();

    // 1) Sessiz saat (Gün 28)
    final quiet = await _quietHours.get();
    if (quiet.isQuietAt(now)) return;

    // 2) Günlük maksimum
    if (await _log.countToday() >= _dailyMax) return;

    final top = recommendations.first;

    // 3) Aynı tip için minimum aralık (dedup)
    final last = await _log.lastShownAt(top.type);
    if (last != null && now.difference(last) < _minInterval) return;

    await _notifications.show(
      id: top.type.index,
      title: 'Yaşam Koçu',
      body: top.message,
      payload: AppRoutes.dashboard,
    );
    await _log.record(top.type, now);
  }
}

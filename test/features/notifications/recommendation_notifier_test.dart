import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/core/services/notifications/notification_service.dart';
import 'package:life_coach/features/notifications/domain/entities/quit_hours.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_log.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_preferences_repository.dart';
import 'package:life_coach/features/notifications/domain/repositories/quiet_hours_repository.dart';
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier_impl.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

class _FakeNotifications implements NotificationService {
  int showCount = 0;
  @override
  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async => showCount++;
  @override
  Future<void> init({void Function(String?)? onNotificationTap}) async {}
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String? payload,
  }) async {}
  @override
  Future<void> cancel(int id) async {}
  @override
  Future<void> cancelAll() async {}
}

class _FakePrefs implements NotificationPreferencesRepository {
  _FakePrefs({this.enabled = true});
  final bool enabled;
  @override
  Future<bool> isEnabled(RecommendationType type) async => enabled;
  @override
  Future<void> setEnabled(
    RecommendationType type, {
    required bool enabled,
  }) async {}
}

class _FakeQuietHours implements QuietHoursRepository {
  // 0-0 => hiç sessiz değil
  @override
  Future<QuietHours> get() async => const QuietHours(startHour: 0, endHour: 0);
  @override
  Future<void> set(QuietHours quietHours) async {}
}

class _FakeLog implements NotificationLog {
  _FakeLog({this.count = 0, this.last});
  int count;
  DateTime? last;
  int recordCount = 0;
  @override
  Future<int> countToday() async => count;
  @override
  Future<DateTime?> lastShownAt(RecommendationType type) async => last;
  @override
  Future<void> record(RecommendationType type, DateTime at) async =>
      recordCount++;
}

const _recs = [
  Recommendation(
    type: RecommendationType.movement,
    message: 'yürü',
    priority: 3,
  ),
];

void main() {
  test('uygun koşulda gösterir ve kaydeder', () async {
    final notifications = _FakeNotifications();
    final log = _FakeLog();
    final notifier = RecommendationNotifierImpl(
      notifications,
      _FakeQuietHours(),
      log,
      _FakePrefs(),
    );

    await notifier.notify(_recs);

    expect(notifications.showCount, 1);
    expect(log.recordCount, 1);
  });
  // yeni test:
  test('opt-out edilen tip gösterilmez', () async {
    final notifications = _FakeNotifications();
    final notifier = RecommendationNotifierImpl(
      notifications,
      _FakeQuietHours(),
      _FakeLog(),
      _FakePrefs(enabled: false), // tip kapalı
    );

    await notifier.notify(_recs);

    expect(notifications.showCount, 0);
  });
  test('günlük maks aşılınca göstermez', () async {
    final notifications = _FakeNotifications();
    final notifier = RecommendationNotifierImpl(
      notifications,
      _FakeQuietHours(),
      _FakeLog(count: 4),
      _FakePrefs(),
    );

    await notifier.notify(_recs);

    expect(notifications.showCount, 0);
  });

  test('aynı tip min aralık içinde gösterilmez', () async {
    final notifications = _FakeNotifications();
    final notifier = RecommendationNotifierImpl(
      notifications,
      _FakeQuietHours(),
      _FakeLog(last: DateTime.now()), // az önce gösterildi
      _FakePrefs(),
    );

    await notifier.notify(_recs);

    expect(notifications.showCount, 0);
  });

  test('min aralık geçince tekrar gösterir', () async {
    final notifications = _FakeNotifications();
    final notifier = RecommendationNotifierImpl(
      notifications,
      _FakeQuietHours(),
      _FakeLog(last: DateTime.now().subtract(const Duration(hours: 2))),
      _FakePrefs(),
    );

    await notifier.notify(_recs);

    expect(notifications.showCount, 1);
  });
}

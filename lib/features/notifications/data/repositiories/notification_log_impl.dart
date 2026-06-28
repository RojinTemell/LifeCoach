import 'package:injectable/injectable.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_log.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: NotificationLog)
class NotificationLogImpl implements NotificationLog {
  NotificationLogImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _countKey = 'notif_count';
  static const _countDateKey = 'notif_count_date';

  String _lastKey(RecommendationType type) => 'notif_last_${type.name}';
  String _today(DateTime d) => '${d.year}-${d.month}-${d.day}';

  @override
  Future<DateTime?> lastShownAt(RecommendationType type) async {
    final ms = _prefs.getInt(_lastKey(type));
    return ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  @override
  Future<int> countToday() async {
    if (_prefs.getString(_countDateKey) != _today(DateTime.now())) return 0;
    return _prefs.getInt(_countKey) ?? 0;
  }

  @override
  Future<void> record(RecommendationType type, DateTime at) async {
    await _prefs.setInt(_lastKey(type), at.millisecondsSinceEpoch);
    final today = _today(at);
    final current = _prefs.getString(_countDateKey) == today
        ? (_prefs.getInt(_countKey) ?? 0)
        : 0;
    await _prefs.setString(_countDateKey, today);
    await _prefs.setInt(_countKey, current + 1);
  }
}

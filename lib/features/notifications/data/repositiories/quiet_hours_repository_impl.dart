import 'package:injectable/injectable.dart';
import 'package:life_coach/features/notifications/domain/entities/quit_hours.dart';
import 'package:life_coach/features/notifications/domain/repositories/quiet_hours_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: QuietHoursRepository)
class QuietHoursRepositoryImpl implements QuietHoursRepository {
  QuietHoursRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const _startKey = 'quiet_start';
  static const _endKey = 'quiet_end';
  static const _default = QuietHours(startHour: 22, endHour: 8);

  @override
  Future<QuietHours> get() async {
    final start = _prefs.getInt(_startKey);
    final end = _prefs.getInt(_endKey);
    if (start == null || end == null) return _default;
    return QuietHours(startHour: start, endHour: end);
  }

  @override
  Future<void> set(QuietHours quietHours) async {
    await _prefs.setInt(_startKey, quietHours.startHour);
    await _prefs.setInt(_endKey, quietHours.endHour);
  }
}

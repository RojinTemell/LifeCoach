import 'package:injectable/injectable.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_preferences_repository.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: NotificationPreferencesRepository)
class NotificationPreferencesRepositoryImpl
    implements NotificationPreferencesRepository {
  NotificationPreferencesRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  String _key(RecommendationType type) => 'notif_enabled_${type.name}';

  @override
  Future<bool> isEnabled(RecommendationType type) async =>
      _prefs.getBool(_key(type)) ?? true; // varsayılan: açık

  @override
  Future<void> setEnabled(RecommendationType type, {required bool enabled}) =>
      _prefs.setBool(_key(type), enabled);
}

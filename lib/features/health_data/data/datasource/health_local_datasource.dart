import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:life_coach/features/health_data/data/models/health_snapshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class HealthLocalDataSource {
  Future<HealthSnapshot?> getSnapshot();
  Future<void> cacheSnapshot(HealthSnapshot snapshot);
}

@LazySingleton(as: HealthLocalDataSource)
class HealthLocalDataSourceImpl implements HealthLocalDataSource {
  HealthLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'health_snapshot';

  @override
  Future<HealthSnapshot?> getSnapshot() async {
    final raw = _prefs.getString(_key);
    if (raw == null) return null;
    return HealthSnapshot.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> cacheSnapshot(HealthSnapshot snapshot) async {
    await _prefs.setString(_key, jsonEncode(snapshot.toJson()));
  }
}

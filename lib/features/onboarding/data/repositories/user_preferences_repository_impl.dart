import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:life_coach/features/onboarding/domain/entities/user_profile.dart';
import 'package:life_coach/features/onboarding/domain/repositories/user_preferences_repository.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: UserPreferencesRepository)
class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  UserPreferencesRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _goalKey = 'user_goal';
  static const _profileKey = 'user_profile';
  @override
  Future<UserProfile?> getProfile() async {
    final raw = _prefs.getString(_profileKey);
    if (raw == null) return null;
    return UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> setProfile(UserProfile profile) =>
      _prefs.setString(_profileKey, jsonEncode(profile.toJson()));

  @override
  Future<UserGoal?> getGoal() async {
    final name = _prefs.getString(_goalKey);
    if (name == null) return null;
    return UserGoal.values.asNameMap()[name]; // string → enum
  }

  @override
  Future<void> setGoal(UserGoal goal) => _prefs.setString(_goalKey, goal.name);
}

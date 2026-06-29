import 'package:life_coach/features/onboarding/domain/entities/user_profile.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';

abstract interface class UserPreferencesRepository {
  Future<UserGoal?> getGoal();
  Future<void> setGoal(UserGoal goal);
  Future<UserProfile?> getProfile();
  Future<void> setProfile(UserProfile profile);
}

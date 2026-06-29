import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_coach/features/onboarding/domain/entities/user_profile.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';

part 'user_context.freezed.dart';
part 'user_context.g.dart';

@freezed
abstract class UserContext with _$UserContext {
  const factory UserContext({
    required DateTime timestamp,
    required int steps,
    required double distanceMeters,
    required UserGoal goal,
    UserProfile? profile,
  }) = _UserContext;
  factory UserContext.fromJson(Map<String, dynamic> json) =>
      _$UserContextFromJson(json);
}

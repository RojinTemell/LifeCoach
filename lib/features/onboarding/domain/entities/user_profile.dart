import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum BiologicalSex { male, female, unspecified }

enum ActivityLevel { sedentary, light, moderate, active }

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int age,
    required int heightCm,
    required int weightKg,
    required BiologicalSex sex,
    required ActivityLevel activityLevel,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

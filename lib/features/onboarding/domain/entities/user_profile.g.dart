// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  age: (json['age'] as num).toInt(),
  heightCm: (json['heightCm'] as num).toInt(),
  weightKg: (json['weightKg'] as num).toInt(),
  sex: $enumDecode(_$BiologicalSexEnumMap, json['sex']),
  activityLevel: $enumDecode(_$ActivityLevelEnumMap, json['activityLevel']),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'age': instance.age,
      'heightCm': instance.heightCm,
      'weightKg': instance.weightKg,
      'sex': _$BiologicalSexEnumMap[instance.sex]!,
      'activityLevel': _$ActivityLevelEnumMap[instance.activityLevel]!,
    };

const _$BiologicalSexEnumMap = {
  BiologicalSex.male: 'male',
  BiologicalSex.female: 'female',
  BiologicalSex.unspecified: 'unspecified',
};

const _$ActivityLevelEnumMap = {
  ActivityLevel.sedentary: 'sedentary',
  ActivityLevel.light: 'light',
  ActivityLevel.moderate: 'moderate',
  ActivityLevel.active: 'active',
};

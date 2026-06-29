// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserContext _$UserContextFromJson(Map<String, dynamic> json) => _UserContext(
  timestamp: DateTime.parse(json['timestamp'] as String),
  steps: (json['steps'] as num).toInt(),
  distanceMeters: (json['distanceMeters'] as num).toDouble(),
  goal: $enumDecode(_$UserGoalEnumMap, json['goal']),
  profile: json['profile'] == null
      ? null
      : UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserContextToJson(_UserContext instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'steps': instance.steps,
      'distanceMeters': instance.distanceMeters,
      'goal': _$UserGoalEnumMap[instance.goal]!,
      'profile': instance.profile,
    };

const _$UserGoalEnumMap = {
  UserGoal.moreMovement: 'moreMovement',
  UserGoal.betterSleep: 'betterSleep',
  UserGoal.breakRhythm: 'breakRhythm',
  UserGoal.reduceScreenTime: 'reduceScreenTime',
  UserGoal.focus: 'focus',
  UserGoal.hydration: 'hydration',
};

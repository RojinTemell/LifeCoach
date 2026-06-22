// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    _Recommendation(
      type: $enumDecode(_$RecommendationTypeEnumMap, json['type']),
      message: json['message'] as String,
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$RecommendationToJson(_Recommendation instance) =>
    <String, dynamic>{
      'type': _$RecommendationTypeEnumMap[instance.type]!,
      'message': instance.message,
      'priority': instance.priority,
    };

const _$RecommendationTypeEnumMap = {
  RecommendationType.movement: 'movement',
  RecommendationType.hydration: 'hydration',
  RecommendationType.breakStretch: 'breakStretch',
  RecommendationType.sleepPrep: 'sleepPrep',
  RecommendationType.screenTime: 'screenTime',
  RecommendationType.reading: 'reading',
};

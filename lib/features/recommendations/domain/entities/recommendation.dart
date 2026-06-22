import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

part 'recommendation.freezed.dart';
part 'recommendation.g.dart';

@freezed
abstract class Recommendation with _$Recommendation {
  const factory Recommendation({
    required RecommendationType type,
    required String message,
    required int priority,
  }) = _Recommendation;
  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
}

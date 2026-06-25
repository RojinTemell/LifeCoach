import 'package:equatable/equatable.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';

enum RecommendationsStatus { initial, loading, success, failure }

class RecommendationsState extends Equatable {
  const RecommendationsState({
    this.status = RecommendationsStatus.initial,
    this.recommendations = const [],
    this.errorMessage,
  });

  final RecommendationsStatus status;
  final List<Recommendation> recommendations;
  final String? errorMessage;

  RecommendationsState copyWith({
    RecommendationsStatus? status,
    List<Recommendation>? recommendations,
    String? errorMessage,
  }) {
    return RecommendationsState(
      status: status ?? this.status,
      recommendations: recommendations ?? this.recommendations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, recommendations, errorMessage];
}

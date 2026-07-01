import 'package:equatable/equatable.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

class NotificationSettingsState extends Equatable {
  const NotificationSettingsState({
    this.enabled = const {},
    this.isLoading = true,
  });
  final Map<RecommendationType, bool> enabled;
  final bool isLoading;

  NotificationSettingsState copyWith({
    Map<RecommendationType, bool>? enabled,
    bool? isLoading,
  }) => NotificationSettingsState(
    enabled: enabled ?? this.enabled,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  List<Object?> get props => [enabled, isLoading];
}

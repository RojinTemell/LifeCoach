import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/features/notifications/domain/repositories/notification_preferences_repository.dart';
import 'package:life_coach/features/notifications/presentation/cubit/notification_settings_state.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

@injectable
class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit(this._repo)
    : super(const NotificationSettingsState());

  final NotificationPreferencesRepository _repo;

  Future<void> load() async {
    final map = {
      for (final type in RecommendationType.values)
        type: await _repo.isEnabled(type),
    };
    emit(NotificationSettingsState(enabled: map, isLoading: false));
  }

  Future<void> toggle(RecommendationType type, {required bool value}) async {
    await _repo.setEnabled(type, enabled: value);
    emit(state.copyWith(enabled: {...state.enabled, type: value}));
  }
}

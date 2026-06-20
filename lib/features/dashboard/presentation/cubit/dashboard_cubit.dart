import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._healthRepository) : super(const DashboardState());
  final HealthRepository _healthRepository;
  Future<void> loadToday() async {
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
      final granted = await _healthRepository.requestPermission();
      if (!granted) {
        emit(
          state.copyWith(
            status: DashboardStatus.failure,
            errorMessage: 'Sağlık izni verilmedi.',
          ),
        );
        return;
      }
      final result = await _healthRepository.getTodaySteps();
      result.match(
        (failure) => emit(
          state.copyWith(
            status: DashboardStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (steps) =>
            emit(state.copyWith(status: DashboardStatus.success, steps: steps)),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: 'Beklenmeyen hata: $e',
        ),
      );
    }
  }
}

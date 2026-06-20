import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:life_coach/core/error/failures.dart';
import 'package:life_coach/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:life_coach/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';

class _FakeHealthRepository implements HealthRepository {
  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<Either<Failure, int>> getTodaySteps() async => const Right(4200);

  @override
  Future<Either<Failure, double>> getTodayDistance() async => const Right(0);
}

void main() {
  test('loadToday: izin verilince success + steps emit eder', () async {
    final cubit = DashboardCubit(_FakeHealthRepository());
    await cubit.loadToday();
    expect(cubit.state.status, DashboardStatus.success);
    expect(cubit.state.steps, 4200);
  });
}

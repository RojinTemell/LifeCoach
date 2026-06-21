import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/core/error/failures.dart';
import 'package:life_coach/features/health_data/data/datasource/health_device_datasource.dart';
import 'package:life_coach/features/health_data/data/datasource/health_local_datasource.dart';
import 'package:life_coach/features/health_data/data/models/health_snapshot.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';

@LazySingleton(as: HealthRepository)
class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl(this._device, this._local);

  final HealthDeviceDataSource _device;
  final HealthLocalDataSource _local;

  static const _freshness = Duration(minutes: 15);

  @override
  Future<bool> requestPermission() => _device.requestPermissions();

  @override
  Future<Either<Failure, int>> getTodaySteps() async =>
      (await _todaySnapshot()).map((s) => s.steps);

  @override
  Future<Either<Failure, double>> getTodayDistance() async =>
      (await _todaySnapshot()).map((s) => s.distanceMeters);

  Future<Either<Failure, HealthSnapshot>> _todaySnapshot() async {
    try {
      final now = DateTime.now();
      final cached = await _local.getSnapshot();
      // KARAR: cache bugüne ait ve tazeyse → cihazı hiç yorma
      if (cached != null &&
          _isSameDay(cached.date, now) &&
          now.difference(cached.syncedAt) < _freshness) {
        return Right(cached);
      }
      // cache yok/eski → cihazdan çek + cache'le
      final steps = await _device.getTodaySteps();
      final distance = await _device.getTodayDistance();
      final snapshot = HealthSnapshot(
        date: now,
        steps: steps,
        distanceMeters: distance,
        syncedAt: now,
      );
      await _local.cacheSnapshot(snapshot);
      return Right(snapshot);
    } on Exception catch (e) {
      return Left(HealthDataFailure(e.toString()));
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

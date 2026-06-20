import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:life_coach/core/error/failures.dart';
import 'package:life_coach/features/health_data/data/datasource/health_device_datasource.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';

@LazySingleton(as: HealthRepository)
class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl(this._dataSource);

  final HealthDeviceDataSource _dataSource;
  @override
  Future<bool> requestPermission() => _dataSource.requestPermissions();
  @override
  Future<Either<Failure, int>> getTodaySteps() async {
    try {
      return Right(await _dataSource.getTodaySteps());
    } on Exception catch (e) {
      return Left(HealthDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getTodayDistance() async {
    try {
      return Right(await _dataSource.getTodayDistance());
    } on Exception catch (e) {
      return Left(HealthDataFailure(e.toString()));
    }
  }
}

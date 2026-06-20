import 'package:injectable/injectable.dart';
import 'package:life_coach/features/health_data/data/datasource/health_device_datasource.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';

@LazySingleton(as: HealthRepository)
class HealthRepositoryImpl implements HealthRepository {
  HealthRepositoryImpl(this._dataSource);

  final HealthDeviceDataSource _dataSource;

  @override
  Future<int> getTodaySteps() => _dataSource.getTodaySteps();

  @override
  Future<bool> requestPermission() => _dataSource.requestPermissions();
}

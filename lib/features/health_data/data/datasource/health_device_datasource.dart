import 'package:health/health.dart';
import 'package:injectable/injectable.dart';

abstract interface class HealthDeviceDataSource {
  Future<bool> requestPermissions();
  Future<int> getTodaySteps();
}

@LazySingleton(as: HealthDeviceDataSource)
class HealthDeviceDataSourceImpl implements HealthDeviceDataSource {
  HealthDeviceDataSourceImpl(this._health);
  final Health _health;
  static const List<HealthDataType> _types = [HealthDataType.STEPS];
  static const List<HealthDataAccess> _permissions = [HealthDataAccess.READ];

  @override
  Future<int> getTodaySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final steps = await _health.getTotalStepsInInterval(midnight, now);
    return steps ?? 0;
  }

  @override
  Future<bool> requestPermissions() async {
    await _health.configure();
    return _health.requestAuthorization(_types, permissions: _permissions);
  }
}

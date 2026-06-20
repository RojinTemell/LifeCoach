import 'package:health/health.dart';
import 'package:injectable/injectable.dart';

abstract interface class HealthDeviceDataSource {
  Future<bool> requestPermissions();
  Future<bool> hasPermissions();
  Future<int> getTodaySteps();
  Future<double> getTodayDistance();
}

@LazySingleton(as: HealthDeviceDataSource)
class HealthDeviceDataSourceImpl implements HealthDeviceDataSource {
  HealthDeviceDataSourceImpl(this._health);
  final Health _health;
  static const List<HealthDataType> _types = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_WALKING_RUNNING,
  ];
  static const List<HealthDataAccess> _permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  @override
  Future<bool> requestPermissions() async {
    await _health.configure();
    return _health.requestAuthorization(_types, permissions: _permissions);
  }

  @override
  Future<bool> hasPermissions() async {
    await _health.configure();
    final granted = await _health.hasPermissions(
      _types,
      permissions: _permissions,
    );
    return granted ?? false;
  }

  @override
  Future<int> getTodaySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final steps = await _health.getTotalStepsInInterval(midnight, now);
    return steps ?? 0;
  }

  @override
  Future<double> getTodayDistance() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final points = await _health.getHealthDataFromTypes(
      types: const [HealthDataType.DISTANCE_WALKING_RUNNING],
      startTime: midnight,
      endTime: now,
    );
    var meters = 0.0;
    for (final p in points) {
      final v = p.value;
      if (v is NumericHealthValue) {
        meters += v.numericValue.toDouble();
      }
    }
    return meters;
  }
}

import 'dart:io';

import 'package:health/health.dart';
import 'package:injectable/injectable.dart';

abstract interface class HealthDeviceDataSource {
  Future<bool> requestPermissions();
  // Future<bool> hasPermissions();
  Future<int> getTodaySteps();
  Future<double> getTodayDistance();
}

@LazySingleton(as: HealthDeviceDataSource)
class HealthDeviceDataSourceImpl implements HealthDeviceDataSource {
  HealthDeviceDataSourceImpl(this._health);
  final Health _health;

  HealthDataType get _distanceType => Platform.isAndroid
      ? HealthDataType.DISTANCE_DELTA
      : HealthDataType.DISTANCE_WALKING_RUNNING;

  List<HealthDataType> get _types => [HealthDataType.STEPS, _distanceType];
  List<HealthDataAccess> get _permissions =>
      _types.map((_) => HealthDataAccess.READ).toList();

  @override
  Future<bool> requestPermissions() async {
    await _health.configure();
    return _health.requestAuthorization(_types, permissions: _permissions);
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
      types: [_distanceType],
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

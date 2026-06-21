import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/health_data/data/datasource/health_device_datasource.dart';
import 'package:life_coach/features/health_data/data/datasource/health_local_datasource.dart';
import 'package:life_coach/features/health_data/data/models/health_snapshot.dart';
import 'package:life_coach/features/health_data/data/repositories/health_repository_impl.dart';

// Sahte cihaz datasource'u — kaç kez çağrıldığını sayar
class _FakeDeviceDataSource implements HealthDeviceDataSource {
  int stepsCallCount = 0;

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<int> getTodaySteps() async {
    stepsCallCount++;
    return 1000;
  }

  @override
  Future<double> getTodayDistance() async => 500;
}

// Sahte local datasource — bellekte tutar
class _FakeLocalDataSource implements HealthLocalDataSource {
  HealthSnapshot? stored;
  int cacheCallCount = 0;

  @override
  Future<HealthSnapshot?> getSnapshot() async => stored;

  @override
  Future<void> cacheSnapshot(HealthSnapshot snapshot) async {
    cacheCallCount++;
    stored = snapshot;
  }
}

void main() {
  late _FakeDeviceDataSource device;
  late _FakeLocalDataSource local;
  late HealthRepositoryImpl repository;

  setUp(() {
    device = _FakeDeviceDataSource();
    local = _FakeLocalDataSource();
    repository = HealthRepositoryImpl(device, local);
  });

  test('cache yoksa cihazdan çeker ve cacheler', () async {
    final result = await repository.getTodaySteps();

    expect(result.getOrElse((_) => -1), 1000); // cihaz değeri
    expect(device.stepsCallCount, 1); // cihaz çağrıldı
    expect(local.cacheCallCount, 1); // cachelendi
  });

  test('cache tazeyse cihazi CAGIRMAZ', () async {
    final now = DateTime.now();
    local.stored = HealthSnapshot(
      date: DateTime(now.year, now.month, now.day),
      steps: 7777,
      distanceMeters: 0,
      syncedAt: now, // taze
    );

    final result = await repository.getTodaySteps();

    expect(result.getOrElse((_) => -1), 7777); // cacheten geldi
    expect(device.stepsCallCount, 0); // cihaz HIC cagrilmadi
  });

  test('cache eskiyse cihazdan yeniden ceker', () async {
    final now = DateTime.now();
    local.stored = HealthSnapshot(
      date: DateTime(now.year, now.month, now.day),
      steps: 7777,
      distanceMeters: 0,
      syncedAt: now.subtract(const Duration(hours: 1)), // eski (>15 dk)
    );

    final result = await repository.getTodaySteps();

    expect(result.getOrElse((_) => -1), 1000); // cihazdan geldi
    expect(device.stepsCallCount, 1);
  });
}

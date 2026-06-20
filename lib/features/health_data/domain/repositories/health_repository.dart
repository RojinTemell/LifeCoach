abstract interface class HealthRepository {
  Future<bool> requestPermission();
  Future<int> getTodaySteps();
}

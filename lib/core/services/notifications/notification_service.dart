abstract interface class NotificationService {
  Future<void> init();
  Future<bool> requestPermission();
  Future<void> show({
    required int id,
    required String title,
    required String body,
  });
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
  });
  Future<void> cancel(int id);
  Future<void> cancelAll();
}

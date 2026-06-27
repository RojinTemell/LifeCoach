abstract interface class NotificationService {
  Future<void> init({void Function(String? payload)? onNotificationTap});
  Future<bool> requestPermission();
  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
  });
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String? payload,
  });
  Future<void> cancel(int id);
  Future<void> cancelAll();
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  // Saat dilimi (zamanlanmış bildirimler için)
  tzdata.initializeTimeZones();
  final timeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZone.identifier));

  // Başlatma ayarları
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  const settings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );
  await notificationsPlugin.initialize(settings: settings);
}

Future<bool> requestNotificationPermission() async {
  final ios = notificationsPlugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >();
  final iosGranted = await ios?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );

  final android = notificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();
  final androidGranted = await android?.requestNotificationsPermission();

  return (iosGranted ?? false) || (androidGranted ?? false);
}

Future<void> showTestNotification() async {
  const details = NotificationDetails(
    android: AndroidNotificationDetails(
      'test_channel',
      'Test Bildirimleri',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );
  await notificationsPlugin.show(
    id: 0,
    title: 'Merhaba! 👋',
    body: 'Bildirimler çalışıyor 🎉',
    notificationDetails: details,
  );
}

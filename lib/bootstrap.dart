import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/core/services/notifications/notification_setup.dart';

Future<void> bootstrap(Widget Function() builder) async {
  // 1) Flutter framework içi hatalar (build/layout/paint)
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
  };
  // 2) Flutter dışı, platform katmanı hataları
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('PlatformDispatcher error: $error');
    return true;
  };
  // 3) Geri kalan tüm async hatalar bu zone'da yakalanır
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await configureDependencies();
      await initNotifications();
      runApp(builder());
    },
    (error, stack) {
      debugPrint('Zone error: $error');
    },
  );
}

import 'package:injectable/injectable.dart';

@lazySingleton
class AppInfoServices {
  String get appName => 'Life Coach';
}

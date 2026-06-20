import 'package:health/health.dart';
import 'package:injectable/injectable.dart';

// Health() bizim sınıfımız değil (3. parti), o yüzden @injectable koyamayız
@module
abstract class RegisterModel {
  Health get health => Health();
}

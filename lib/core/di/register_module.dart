import 'package:health/health.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Health() bizim sınıfımız değil (3. parti), o yüzden @injectable koyamayız
@module
abstract class RegisterModel {
  Health get health => Health();

  //getInstance metodu async olduğu için @preResolve kullanıyoruz
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

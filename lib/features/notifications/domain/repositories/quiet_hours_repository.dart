import 'package:life_coach/features/notifications/domain/entities/quit_hours.dart';

abstract interface class QuietHoursRepository {
  Future<QuietHours> get();
  Future<void> set(QuietHours quietHours);
}

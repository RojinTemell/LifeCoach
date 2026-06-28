import 'package:equatable/equatable.dart';

class QuietHours extends Equatable {
  const QuietHours({required this.startHour, required this.endHour});

  final int startHour;
  final int endHour;

  bool isQuietAt(DateTime time) {
    final hour = time.hour;
    if (startHour == endHour) return false;
    if (startHour < endHour) {
      return hour >= startHour && hour < endHour;
    }
    return hour >= startHour || hour < endHour;
  }

  @override
  List<Object?> get props => [startHour, endHour];
}

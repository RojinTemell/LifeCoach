import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/notifications/domain/entities/quit_hours.dart';

DateTime _at(int hour) => DateTime(2026, 6, 21, hour);
void main() {
  group('gece sarması (22-08)', () {
    const quiet = QuietHours(startHour: 22, endHour: 8);
    test('gece sessiz', () => expect(quiet.isQuietAt(_at(23)), isTrue));
    test('sabaha karşı sessiz', () => expect(quiet.isQuietAt(_at(2)), isTrue));
    test(
      '08:00 artık sessiz değil',
      () => expect(quiet.isQuietAt(_at(8)), isFalse),
    );
    test('öğlen sessiz değil', () => expect(quiet.isQuietAt(_at(14)), isFalse));
    test('22:00 sessiz başlar', () => expect(quiet.isQuietAt(_at(22)), isTrue));
  });

  group('aynı gün (01-06)', () {
    const quiet = QuietHours(startHour: 1, endHour: 6);
    test('03:00 sessiz', () => expect(quiet.isQuietAt(_at(3)), isTrue));
    test('06:00 değil', () => expect(quiet.isQuietAt(_at(6)), isFalse));
    test('00:00 değil', () => expect(quiet.isQuietAt(_at(0)), isFalse));
  });
}

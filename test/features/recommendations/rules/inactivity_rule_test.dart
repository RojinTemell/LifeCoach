import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/rules/inactivity_rule.dart';

UserContext _ctx({required int hour, required int steps}) => UserContext(
  timestamp: DateTime(2026, 6, 21, hour),
  steps: steps,
  distanceMeters: 0,
  goal: UserGoal.moreMovement,
);

void main() {
  final rule = InactivityRule();
  group('InactivityRule.isApplicable', () {
    test('aktif saatte düşük adımda uygulanabilir', () {
      expect(rule.isApplicable(_ctx(hour: 14, steps: 500)), isTrue);
    });
    test('yüksek adımda uygulanabilir değil', () {
      expect(rule.isApplicable(_ctx(hour: 14, steps: 5000)), isFalse);
    });
    test('gece (aktif saat dışı) uygulanabilir değil', () {
      expect(rule.isApplicable(_ctx(hour: 3, steps: 0)), isFalse);
    });
  });
  test('build hareket önerisi üretir', () {
    final rec = rule.build(_ctx(hour: 14, steps: 500));
    expect(rec.type, RecommendationType.movement);
    expect(rec.message, isNotEmpty);
    expect(rec.priority, greaterThan(0));
  });
}

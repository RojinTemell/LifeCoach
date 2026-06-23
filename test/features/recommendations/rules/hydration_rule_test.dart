import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/rules/hydration_rule.dart';

UserContext _ctx({required int hour}) => UserContext(
  timestamp: DateTime(2026, 6, 21, hour),
  steps: 0,
  distanceMeters: 0,
  goal: UserGoal.hydration,
);

void main() {
  final rule = HydrationRule();
  group('HydrationRule.isApplicable', () {
    test('gündüz uygulanabilir', () {
      expect(rule.isApplicable(_ctx(hour: 10)), isTrue);
    });
    test('gece (erken) uygulanabilir değil', () {
      expect(rule.isApplicable(_ctx(hour: 3)), isFalse);
    });
    test('gece uygulanamaz', () {
      expect(rule.isApplicable(_ctx(hour: 23)), isFalse);
    });
  });
  test('build hidrasyon önerisi üretir', () {
    final rec = rule.build(_ctx(hour: 10));
    expect(rec.type, RecommendationType.hydration);
    expect(rec.message, isNotEmpty);
    expect(rec.priority, greaterThan(0));
  });
}

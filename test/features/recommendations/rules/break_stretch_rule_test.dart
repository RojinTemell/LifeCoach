import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/rules/break_strecth_rule.dart';

UserContext _ctx(int hour) => UserContext(
  timestamp: DateTime(2026, 6, 21, hour),
  steps: 0,
  distanceMeters: 0,
  goal: UserGoal.moreMovement,
);

void main() {
  final rule = BreakStretchRule();

  test('çalışma saatinde uygulanabilir', () {
    expect(rule.isApplicable(_ctx(14)), isTrue);
  });
  test('çalışma saati dışında uygulanabilir değil', () {
    expect(rule.isApplicable(_ctx(20)), isFalse);
  });
  test('build esneme önerisi üretir', () {
    final rec = rule.build(_ctx(14));
    expect(rec.type, RecommendationType.breakStretch);
    expect(rec.message, isNotEmpty);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/domain/rules/sleep_prep_rule.dart';

UserContext _ctx({required int hour, required UserGoal goal}) => UserContext(
  timestamp: DateTime(2026, 6, 21, hour),
  steps: 0,
  distanceMeters: 0,
  goal: goal,
);

void main() {
  final rule = SleepPrepRule();

  test('gece 22de herkes için uygulanabilir', () {
    expect(
      rule.isApplicable(_ctx(hour: 22, goal: UserGoal.moreMovement)),
      isTrue,
    );
  });

  test('21de SADECE uyku hedefi için uygulanabilir', () {
    expect(
      rule.isApplicable(_ctx(hour: 21, goal: UserGoal.betterSleep)),
      isTrue,
    );
    expect(
      rule.isApplicable(_ctx(hour: 21, goal: UserGoal.moreMovement)),
      isFalse,
    );
  });

  test('gündüz uygulanabilir değil', () {
    expect(
      rule.isApplicable(_ctx(hour: 14, goal: UserGoal.betterSleep)),
      isFalse,
    );
  });

  test('uyku hedefinde önceliği daha yüksek', () {
    final sleepGoal = rule.build(_ctx(hour: 22, goal: UserGoal.betterSleep));
    final otherGoal = rule.build(_ctx(hour: 22, goal: UserGoal.moreMovement));
    expect(sleepGoal.priority, greaterThan(otherGoal.priority));
  });
}

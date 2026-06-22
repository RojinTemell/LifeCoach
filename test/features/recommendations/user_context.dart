import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';

void main() {
  test('UserContext JSON round-trip', () {
    final context = UserContext(
      timestamp: DateTime(2026, 6, 21, 14, 30),
      steps: 4200,
      distanceMeters: 3100,
      goal: UserGoal.moreMovement,
    );

    final restored = UserContext.fromJson(context.toJson());

    expect(restored, context); // freezed == sayesinde eşit
  });
}

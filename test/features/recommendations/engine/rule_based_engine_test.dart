import 'package:flutter_test/flutter_test.dart';
import 'package:life_coach/features/recommendations/domain/engine/recommendation_engine.dart';
import 'package:life_coach/features/recommendations/domain/engine/rule.dart';
import 'package:life_coach/features/recommendations/domain/engine/rule_based_engine.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';

class _StubRule implements Rule {
  _StubRule({required this.applicable, required this.rec});
  final bool applicable;
  final Recommendation rec;

  @override
  bool isApplicable(UserContext context) => applicable;
  @override
  Recommendation build(UserContext context) => rec;
}

Recommendation _recommend(int priority) => Recommendation(
  message: 'm$priority',
  type: RecommendationType.movement,
  priority: priority,
);

final _context = UserContext(
  timestamp: DateTime(2026, 6, 21, 14),
  steps: 0,
  distanceMeters: 0,
  goal: UserGoal.moreMovement,
);

void main() {
  test('uygulanabilir olmayan kuralları eler', () async {
    final engine = RuleBasedEngine([
      _StubRule(applicable: true, rec: _recommend(2)),
      _StubRule(applicable: false, rec: _recommend(5)),
    ]);

    final result = await engine.generate(_context);
    expect(result.length, 1);
    expect(result.first.priority, 2);
  });
  test('önceliğe göre azalan sıralar', () async {
    final engine = RuleBasedEngine([
      _StubRule(applicable: true, rec: _recommend(1)),
      _StubRule(applicable: true, rec: _recommend(3)),
    ]);

    final result = await engine.generate(_context);

    expect(result.first.priority, 3);
  });

  test('en fazla maxRecommendations kadar döndürür', () async {
    final engine = RuleBasedEngine(
      [
        _StubRule(applicable: true, rec: _recommend(1)),
        _StubRule(applicable: true, rec: _recommend(2)),
        _StubRule(applicable: true, rec: _recommend(3)),
      ],
      maxRecommendations: 1,
    );

    final result = await engine.generate(_context);

    expect(result.map((r) => r.priority).toList(), [3]);
  });
  test('hiç uygulanabilir kural yoksa boş liste', () async {
    final engine = RuleBasedEngine([
      _StubRule(applicable: false, rec: _recommend(1)),
    ]);
    expect(await engine.generate(_context), isEmpty);
  });
  test('RecommendationEngine arayüzünü uygular', () {
    expect(RuleBasedEngine(const []), isA<RecommendationEngine>());
  });
}

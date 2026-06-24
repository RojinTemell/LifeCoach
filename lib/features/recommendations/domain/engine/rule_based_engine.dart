import 'package:life_coach/features/recommendations/domain/engine/recommendation_engine.dart';
import 'package:life_coach/features/recommendations/domain/engine/rule.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_context.dart';

class RuleBasedEngine implements RecommendationEngine {
  RuleBasedEngine(this._rules, {this.maxRecommendations = 2});

  final List<Rule> _rules;
  final int maxRecommendations;
  @override
  Future<List<Recommendation>> generate(UserContext context) async {
    final recommendations =
        _rules
            .where((rule) => rule.isApplicable(context))
            .map((rule) => rule.build(context))
            .toList()
          ..sort((a, b) => b.priority.compareTo(a.priority));
    return recommendations.take(maxRecommendations).toList();
  }
}

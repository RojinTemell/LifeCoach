import 'package:injectable/injectable.dart';
import 'package:life_coach/features/recommendations/domain/engine/recommendation_engine.dart';
import 'package:life_coach/features/recommendations/domain/engine/rule.dart';
import 'package:life_coach/features/recommendations/domain/engine/rule_based_engine.dart';
import 'package:life_coach/features/recommendations/domain/rules/break_strecth_rule.dart';
import 'package:life_coach/features/recommendations/domain/rules/hydration_rule.dart';
import 'package:life_coach/features/recommendations/domain/rules/inactivity_rule.dart';
import 'package:life_coach/features/recommendations/domain/rules/sleep_prep_rule.dart';

@module
abstract class RecommendationModule {
  @lazySingleton
  List<Rule> rules(
    InactivityRule inactivity,
    HydrationRule hydration,
    BreakStretchRule breakStretch,
    SleepPrepRule sleepPrep,
  ) => [inactivity, hydration, breakStretch, sleepPrep];

  @lazySingleton
  RecommendationEngine engine(List<Rule> rules) => RuleBasedEngine(rules);
}

import 'package:flutter/material.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({required this.recommendation, super.key});
  final Recommendation recommendation;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(recommendation.type.icon),
        title: Text(recommendation.message),
      ),
    );
  }
}

extension on RecommendationType {
  IconData get icon => switch (this) {
    RecommendationType.movement => Icons.directions_walk,
    RecommendationType.hydration => Icons.local_drink,
    RecommendationType.breakStretch => Icons.self_improvement,
    RecommendationType.sleepPrep => Icons.bedtime,
    RecommendationType.screenTime => Icons.phone_android,
    RecommendationType.reading => Icons.menu_book,
  };
}

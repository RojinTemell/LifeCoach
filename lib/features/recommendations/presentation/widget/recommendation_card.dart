import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_feedback.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_cubit.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({required this.recommendation, super.key});

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecommendationsCubit>();
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(recommendation.type.icon),
            title: Text(recommendation.message),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => cubit.recordFeedback(
                  recommendation,
                  RecommendationFeedback.done,
                ),
                child: const Text('Yaptım'),
              ),
              TextButton(
                onPressed: () => cubit.recordFeedback(
                  recommendation,
                  RecommendationFeedback.notNow,
                ),
                child: const Text('Şimdi değil'),
              ),
              TextButton(
                onPressed: () => cubit.recordFeedback(
                  recommendation,
                  RecommendationFeedback.notInterested,
                ),
                child: const Text('İlgilenmiyorum'),
              ),
            ],
          ),
        ],
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

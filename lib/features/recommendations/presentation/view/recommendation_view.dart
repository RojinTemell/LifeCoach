import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_cubit.dart';
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_state.dart';
import 'package:life_coach/features/recommendations/presentation/widget/recommendation_card.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<RecommendationsCubit>();

        unawaited(cubit.load(goal: UserGoal.moreMovement));
        return cubit;
      },
      child: const _RecommendationList(),
    );
  }
}

class _RecommendationList extends StatelessWidget {
  const _RecommendationList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendationsCubit, RecommendationsState>(
      builder: (context, state) {
        return switch (state.status) {
          RecommendationsStatus.initial || RecommendationsStatus.loading =>
            const Center(child: CircularProgressIndicator()),
          RecommendationsStatus.failure => _ErrorView(
            message: state.errorMessage ?? 'Bir hata oluştu',
          ),
          RecommendationsStatus.success =>
            state.recommendations.isEmpty
                ? const _EmptyView()
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      for (final rec in state.recommendations)
                        RecommendationCard(recommendation: rec),
                    ],
                  ),
        };
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Şu an için bir önerimiz yok. Harika gidiyorsun! 🎉',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 12),
          Text(message),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.read<RecommendationsCubit>().load(
              goal: UserGoal.moreMovement,
            ),
            child: const Text('Tekrar dene'),
          ),
        ],
      ),
    );
  }
}

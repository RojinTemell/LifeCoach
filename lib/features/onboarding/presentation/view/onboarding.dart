import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_coach/app/router/app_router.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/features/onboarding/domain/repositories/user_preferences_repository.dart';
import 'package:life_coach/features/recommendations/domain/entities/user_goal.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                'Hoş geldin! 👋',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text('Sana nasıl yardımcı olmamı istersin?'),
              const SizedBox(height: 32),
              const _GoalCard(
                goal: UserGoal.moreMovement,
                title: 'Daha çok hareket',
                icon: Icons.directions_walk,
              ),
              const _GoalCard(
                goal: UserGoal.betterSleep,
                title: 'Daha iyi uyku',
                icon: Icons.bedtime,
              ),
              const _GoalCard(
                goal: UserGoal.breakRhythm,
                title: 'Mola ritmi',
                icon: Icons.self_improvement,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.title,
    required this.icon,
  });

  final UserGoal goal;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          await getIt<UserPreferencesRepository>().setGoal(goal);
          OnboardingGate.isComplete = true;
          if (!context.mounted) return;
          context.go(AppRoutes.dashboard);
        },
      ),
    );
  }
}

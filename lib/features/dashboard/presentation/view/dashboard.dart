import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:life_coach/features/dashboard/presentation/cubit/dashboard_state.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        //Bu fonksiyonun Future döndürdüğünü biliyo ve onu bilerek beklemiyo
        final cubit = getIt<DashboardCubit>();
        unawaited(cubit.loadToday());
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bugün'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.push(AppRoutes.settings),
            ),
          ],
        ),
        body: const _DashboardBody(),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return switch (state.status) {
          DashboardStatus.initial || DashboardStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          DashboardStatus.success => _StepsView(steps: state.steps),
          DashboardStatus.failure => _ErrorView(
            message: state.errorMessage ?? 'Bilinmeyen bir hata oluştu.',
          ),
        };
      },
    );
  }
}

class _StepsView extends StatelessWidget {
  const _StepsView({required this.steps});
  final int steps;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.directions_walk, size: 64),
          const SizedBox(height: 16),
          Text('$steps', style: Theme.of(context).textTheme.displayMedium),
          const Text('bugünkü adım'),
          if (steps == 0) ...[
            const SizedBox(height: 8),
            const Text('Henüz veri yok — biraz hareket et!'),
          ],
        ],
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
          const SizedBox(height: 16),
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<DashboardCubit>().loadToday(),
            child: const Text('Tekrar dene'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bugün')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dashboard (yakında)'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final repo = getIt<HealthRepository>();
                final req = await repo.requestPermission();
                final steps = req ? await repo.getTodaySteps() : 0;
                if (!context.mounted) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('İzin: $req · Bugünkü adım: $steps'),
                    ),
                  );
                }
              },
              child: const Text('Sağlık iznini test et'),
            ),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.settings),
              child: const Text('Ayarlar'),
            ),
          ],
        ),
      ),
    );
  }
}

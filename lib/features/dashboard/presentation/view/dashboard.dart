import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health/health.dart';
import 'package:life_coach/app/router/app_routes.dart';

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
                final health = Health();
                await health.configure();
                final granted = await health.requestAuthorization(
                  [HealthDataType.STEPS],
                  permissions: [HealthDataAccess.READ],
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sağlık izni sonucu: $granted')),
                );
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

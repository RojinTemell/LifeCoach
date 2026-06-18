import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              onPressed: () => context.push(AppRoutes.settings),
              child: const Text('Ayarlar'),
            ),
          ],
        ),
      ),
    );
  }
}

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
                final granted = await repo.requestPermission();
                if (!granted) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Sağlık izni verilmedi.')),
                  );
                  return;
                }
                final result = await repo.getTodaySteps();
                final text = result.match(
                  (failure) => 'Hata: ${failure.message}',
                  (steps) => 'Bugünkü adım: $steps',
                );
                messenger.showSnackBar(SnackBar(content: Text(text)));
              },

              // onPressed: () async {
              //   final messenger = ScaffoldMessenger.of(
              //     context,
              //   ); // await'ten ÖNCE
              //   try {
              //     final repo = getIt<HealthRepository>();

              //     final req = await repo.requestPermission();

              //     final steps = req ? await repo.getTodaySteps() : 0;

              //     messenger.showSnackBar(
              //       SnackBar(content: Text('İzin: $req · Adım: $steps')),
              //     );
              //   } on Exception catch (e) {
              //     messenger.showSnackBar(SnackBar(content: Text('HATA: $e')))
              //   }
              // },
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

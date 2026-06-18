import 'package:go_router/go_router.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/features/dashboard/presentation/view/dashboard.dart';
import 'package:life_coach/features/settings/presentation/view/settings.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.dashboard,
  routes: [
    GoRoute(
      path: AppRoutes.dashboard,
      name: 'dashboard',
      builder: (context, state) => const Dashboard(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const Settings(),
    ),
  ],
);

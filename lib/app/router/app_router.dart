import 'package:go_router/go_router.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/features/dashboard/presentation/view/dashboard.dart';
import 'package:life_coach/features/onboarding/presentation/view/onboarding.dart';
import 'package:life_coach/features/settings/presentation/view/settings.dart';

class OnboardingGate {
  static bool isComplete = false; // bootstrap'ta set edilecek
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.dashboard,
  redirect: (context, state) {
    final atOnboarding = state.matchedLocation == AppRoutes.onboarding;
    if (!OnboardingGate.isComplete && !atOnboarding) {
      return AppRoutes.onboarding;
    }
    if (OnboardingGate.isComplete && atOnboarding) return AppRoutes.dashboard;
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const Onboarding(),
    ),
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

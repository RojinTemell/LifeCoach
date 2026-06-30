import 'package:flutter/widgets.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/core/services/notifications/notification_service.dart';
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier.dart';
import 'package:life_coach/features/onboarding/domain/repositories/user_preferences_repository.dart';
import 'package:life_coach/features/recommendations/domain/usecases/generate_recommendations_usecase.dart';
import 'package:workmanager/workmanager.dart';

const recommendationTask = 'recommendationRefresh';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Ayrı isolate → her şeyi yeniden başlat
    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
    await getIt<NotificationService>().init();

    final prefs = getIt<UserPreferencesRepository>();
    final goal = await prefs.getGoal();
    if (goal == null) return true; // onboarding yapılmamış → bir şey yapma

    final result = await getIt<GenerateRecommendationsUseCase>()(
      goal: goal,
      profile: await prefs.getProfile(),
    );

    await result.fold(
      (failure) async {},
      (recs) => getIt<RecommendationNotifier>().notify(recs),
    );
    return true;
  });
}

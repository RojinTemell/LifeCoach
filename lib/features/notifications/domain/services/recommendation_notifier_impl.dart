import 'package:injectable/injectable.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/services/notifications/notification_service.dart';
import 'package:life_coach/features/notifications/domain/repositories/quiet_hours_repository.dart';
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation.dart';

@LazySingleton(as: RecommendationNotifier)
class RecommendationNotifierImpl implements RecommendationNotifier {
  RecommendationNotifierImpl(this._notifications, this._quietHours);

  final NotificationService _notifications;
  final QuietHoursRepository _quietHours;
  @override
  Future<void> notify(List<Recommendation> recommendations) async {
    if (recommendations.isEmpty) return;
    final quiet = await _quietHours.get();
    if (quiet.isQuietAt(DateTime.now())) return;
    final top = recommendations.first;
    await _notifications.show(
      id: top.type.index,
      title: 'Yaşam Koçu',
      body: top.message,
      payload: AppRoutes.dashboard,
    );
  }
}

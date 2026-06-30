import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:life_coach/features/recommendations/domain/entities/feedback_event.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_feedback.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';
import 'package:life_coach/features/recommendations/domain/repositories/feedback_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: FeedbackRepository)
class FeedbackRepositoryImpl implements FeedbackRepository {
  FeedbackRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'feedback_events';

  @override
  Future<void> record({
    required RecommendationType type,
    required RecommendationFeedback feedback,
    required DateTime at,
  }) async {
    final events = await getAll()
      ..add(FeedbackEvent(type: type, feedback: feedback, at: at));
    await _prefs.setString(
      _key,
      jsonEncode(events.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<List<FeedbackEvent>> getAll() async {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => FeedbackEvent.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

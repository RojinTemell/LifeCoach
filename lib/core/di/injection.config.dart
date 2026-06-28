// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:health/health.dart' as _i237;
import 'package:injectable/injectable.dart' as _i526;
import 'package:life_coach/core/di/register_module.dart' as _i27;
import 'package:life_coach/core/services/notifications/notification_service.dart'
    as _i998;
import 'package:life_coach/core/services/notifications/notification_service_impl.dart'
    as _i52;
import 'package:life_coach/features/dashboard/presentation/cubit/dashboard_cubit.dart'
    as _i1012;
import 'package:life_coach/features/health_data/data/datasource/health_device_datasource.dart'
    as _i319;
import 'package:life_coach/features/health_data/data/datasource/health_local_datasource.dart'
    as _i653;
import 'package:life_coach/features/health_data/data/repositories/health_repository_impl.dart'
    as _i407;
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart'
    as _i903;
import 'package:life_coach/features/notifications/data/repositiories/notification_log_impl.dart'
    as _i957;
import 'package:life_coach/features/notifications/data/repositiories/quiet_hours_repository_impl.dart'
    as _i835;
import 'package:life_coach/features/notifications/domain/repositories/notification_log.dart'
    as _i1055;
import 'package:life_coach/features/notifications/domain/repositories/quiet_hours_repository.dart'
    as _i908;
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier.dart'
    as _i172;
import 'package:life_coach/features/notifications/domain/services/recommendation_notifier_impl.dart'
    as _i333;
import 'package:life_coach/features/recommendations/di/recommendation_module.dart'
    as _i684;
import 'package:life_coach/features/recommendations/domain/engine/recommendation_engine.dart'
    as _i106;
import 'package:life_coach/features/recommendations/domain/engine/rule.dart'
    as _i956;
import 'package:life_coach/features/recommendations/domain/rules/break_strecth_rule.dart'
    as _i770;
import 'package:life_coach/features/recommendations/domain/rules/hydration_rule.dart'
    as _i200;
import 'package:life_coach/features/recommendations/domain/rules/inactivity_rule.dart'
    as _i606;
import 'package:life_coach/features/recommendations/domain/rules/sleep_prep_rule.dart'
    as _i350;
import 'package:life_coach/features/recommendations/domain/services/user_context_builder.dart'
    as _i933;
import 'package:life_coach/features/recommendations/domain/usecases/generate_recommendations_usecase.dart'
    as _i890;
import 'package:life_coach/features/recommendations/presentation/cubit/recommendations_cubit.dart'
    as _i452;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModel = _$RegisterModel();
    final recommendationModule = _$RecommendationModule();
    gh.factory<_i237.Health>(() => registerModel.health);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModel.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i770.BreakStretchRule>(() => _i770.BreakStretchRule());
    gh.lazySingleton<_i200.HydrationRule>(() => _i200.HydrationRule());
    gh.lazySingleton<_i606.InactivityRule>(() => _i606.InactivityRule());
    gh.lazySingleton<_i350.SleepPrepRule>(() => _i350.SleepPrepRule());
    gh.lazySingleton<_i319.HealthDeviceDataSource>(
      () => _i319.HealthDeviceDataSourceImpl(gh<_i237.Health>()),
    );
    gh.lazySingleton<_i998.NotificationService>(
      () => _i52.NotificationServiceImpl(),
    );
    gh.lazySingleton<_i1055.NotificationLog>(
      () => _i957.NotificationLogImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i908.QuietHoursRepository>(
      () => _i835.QuietHoursRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i653.HealthLocalDataSource>(
      () => _i653.HealthLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<List<_i956.Rule>>(
      () => recommendationModule.rules(
        gh<_i606.InactivityRule>(),
        gh<_i200.HydrationRule>(),
        gh<_i770.BreakStretchRule>(),
        gh<_i350.SleepPrepRule>(),
      ),
    );
    gh.lazySingleton<_i172.RecommendationNotifier>(
      () => _i333.RecommendationNotifierImpl(
        gh<_i998.NotificationService>(),
        gh<_i908.QuietHoursRepository>(),
        gh<_i1055.NotificationLog>(),
      ),
    );
    gh.lazySingleton<_i106.RecommendationEngine>(
      () => recommendationModule.engine(gh<List<_i956.Rule>>()),
    );
    gh.lazySingleton<_i903.HealthRepository>(
      () => _i407.HealthRepositoryImpl(
        gh<_i319.HealthDeviceDataSource>(),
        gh<_i653.HealthLocalDataSource>(),
      ),
    );
    gh.factory<_i1012.DashboardCubit>(
      () => _i1012.DashboardCubit(gh<_i903.HealthRepository>()),
    );
    gh.factory<_i933.UserContextBuilder>(
      () => _i933.UserContextBuilder(gh<_i903.HealthRepository>()),
    );
    gh.lazySingleton<_i890.GenerateRecommendationsUseCase>(
      () => _i890.GenerateRecommendationsUseCase(
        gh<_i933.UserContextBuilder>(),
        gh<_i106.RecommendationEngine>(),
      ),
    );
    gh.factory<_i452.RecommendationsCubit>(
      () => _i452.RecommendationsCubit(
        gh<_i890.GenerateRecommendationsUseCase>(),
        gh<_i172.RecommendationNotifier>(),
      ),
    );
    return this;
  }
}

class _$RegisterModel extends _i27.RegisterModel {}

class _$RecommendationModule extends _i684.RecommendationModule {}

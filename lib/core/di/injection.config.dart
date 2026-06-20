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
import 'package:life_coach/core/di/register_model.dart' as _i847;
import 'package:life_coach/core/services/app_info_services.dart' as _i842;
import 'package:life_coach/features/dashboard/presentation/cubit/dashboard_cubit.dart'
    as _i1012;
import 'package:life_coach/features/health_data/data/datasource/health_device_datasource.dart'
    as _i319;
import 'package:life_coach/features/health_data/data/repositories/health_repository_impl.dart'
    as _i407;
import 'package:life_coach/features/health_data/domain/repositories/health_repository.dart'
    as _i903;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModel = _$RegisterModel();
    gh.factory<_i237.Health>(() => registerModel.health);
    gh.lazySingleton<_i842.AppInfoServices>(() => _i842.AppInfoServices());
    gh.lazySingleton<_i319.HealthDeviceDataSource>(
      () => _i319.HealthDeviceDataSourceImpl(gh<_i237.Health>()),
    );
    gh.lazySingleton<_i903.HealthRepository>(
      () => _i407.HealthRepositoryImpl(gh<_i319.HealthDeviceDataSource>()),
    );
    gh.factory<_i1012.DashboardCubit>(
      () => _i1012.DashboardCubit(gh<_i903.HealthRepository>()),
    );
    return this;
  }
}

class _$RegisterModel extends _i847.RegisterModel {}

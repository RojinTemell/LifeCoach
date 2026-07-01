import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/features/notifications/presentation/cubit/notification_settings_cubit.dart';
import 'package:life_coach/features/notifications/presentation/cubit/notification_settings_state.dart';
import 'package:life_coach/features/recommendations/domain/entities/recommendation_type.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<NotificationSettingsCubit>();
        unawaited(cubit.load());
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Ayarlar')),
        body: BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: [
                for (final type in RecommendationType.values)
                  SwitchListTile(
                    title: Text(type.label),
                    value: state.enabled[type] ?? true,
                    onChanged: (v) => context
                        .read<NotificationSettingsCubit>()
                        .toggle(type, value: v),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

extension on RecommendationType {
  String get label => switch (this) {
    RecommendationType.movement => 'Hareket',
    RecommendationType.hydration => 'Su içme',
    RecommendationType.breakStretch => 'Mola / esneme',
    RecommendationType.sleepPrep => 'Uyku hazırlığı',
    RecommendationType.screenTime => 'Ekran süresi',
    RecommendationType.reading => 'Okuma',
  };
}

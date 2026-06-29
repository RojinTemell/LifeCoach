import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:life_coach/app/router/app_router.dart';
import 'package:life_coach/app/router/app_routes.dart';
import 'package:life_coach/core/di/injection.dart';
import 'package:life_coach/features/onboarding/domain/entities/user_profile.dart';
import 'package:life_coach/features/onboarding/domain/repositories/user_preferences_repository.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _age = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  BiologicalSex _sex = BiologicalSex.unspecified;
  ActivityLevel _activity = ActivityLevel.moderate;

  @override
  void dispose() {
    _age.dispose();
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final profile = UserProfile(
      age: int.parse(_age.text),
      heightCm: int.parse(_height.text),
      weightKg: int.parse(_weight.text),
      sex: _sex,
      activityLevel: _activity,
    );
    await getIt<UserPreferencesRepository>().setProfile(profile);
    OnboardingGate.isComplete = true;
    if (!mounted) return;
    context.go(AppRoutes.dashboard);
  }

  String? _validateNumber(String? v) {
    if (v == null || v.isEmpty) return 'Gerekli';
    if (int.tryParse(v) == null) return 'Sayı gir';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Yaş'),
              validator: _validateNumber,
            ),
            TextFormField(
              controller: _height,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Boy (cm)'),
              validator: _validateNumber,
            ),
            TextFormField(
              controller: _weight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Kilo (kg)'),
              validator: _validateNumber,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<BiologicalSex>(
              initialValue: _sex,
              decoration: const InputDecoration(labelText: 'Cinsiyet'),
              items: const [
                DropdownMenuItem(
                  value: BiologicalSex.male,
                  child: Text('Erkek'),
                ),
                DropdownMenuItem(
                  value: BiologicalSex.female,
                  child: Text('Kadın'),
                ),
                DropdownMenuItem(
                  value: BiologicalSex.unspecified,
                  child: Text('Belirtmek istemiyorum'),
                ),
              ],
              onChanged: (v) => setState(() => _sex = v!),
            ),
            DropdownButtonFormField<ActivityLevel>(
              initialValue: _activity,
              decoration: const InputDecoration(labelText: 'Aktivite seviyesi'),
              items: const [
                DropdownMenuItem(
                  value: ActivityLevel.sedentary,
                  child: Text('Hareketsiz'),
                ),
                DropdownMenuItem(
                  value: ActivityLevel.light,
                  child: Text('Hafif'),
                ),
                DropdownMenuItem(
                  value: ActivityLevel.moderate,
                  child: Text('Orta'),
                ),
                DropdownMenuItem(
                  value: ActivityLevel.active,
                  child: Text('Aktif'),
                ),
              ],
              onChanged: (v) => setState(() => _activity = v!),
            ),
            const SizedBox(height: 32),
            FilledButton(onPressed: _save, child: const Text('Devam et')),
          ],
        ),
      ),
    );
  }
}

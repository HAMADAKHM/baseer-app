import 'package:baseer/core/storage/shared_preferences_provider.dart';
import 'package:baseer/features/settings/application/settings_controller.dart';
import 'package:baseer/features/settings/domain/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences prefs;
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
  });
  tearDown(() => container.dispose());

  SettingsController controller() =>
      container.read(settingsControllerProvider.notifier);

  test('changes update state and persist', () async {
    await controller().setLanguage(AppLanguage.english);
    await controller().setThemeMode(ThemeMode.dark);
    await controller().completeOnboarding();

    expect(
      container.read(settingsControllerProvider),
      const AppSettings(
        language: AppLanguage.english,
        themeMode: ThemeMode.dark,
        onboardingCompleted: true,
      ),
    );
    expect(prefs.getString('settings.language'), 'english');
    expect(prefs.getString('settings.themeMode'), 'dark');
    expect(prefs.getBool('settings.onboardingCompleted'), isTrue);
  });

  test('deleteAllLocalData wipes storage and resets state', () async {
    await controller().setLanguage(AppLanguage.english);
    await controller().completeOnboarding();

    await controller().deleteAllLocalData();

    expect(prefs.getKeys(), isEmpty);
    expect(container.read(settingsControllerProvider), const AppSettings());
  });
}

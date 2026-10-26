import 'package:baseer/features/settings/data/settings_repository.dart';
import 'package:baseer/features/settings/domain/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<SettingsRepository> repoWith(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    return SettingsRepository(await SharedPreferences.getInstance());
  }

  test('defaults: Arabic, system theme, onboarding not completed', () async {
    final repo = await repoWith({});
    expect(repo.load(), const AppSettings());
    expect(repo.load().locale, const Locale('ar'));
  });

  test('save then load round-trips every field', () async {
    final repo = await repoWith({});
    const s = AppSettings(
      language: AppLanguage.english,
      themeMode: ThemeMode.dark,
      onboardingCompleted: true,
    );
    await repo.save(s);
    expect(repo.load(), s);
  });

  test('unknown stored values fall back to defaults', () async {
    final repo = await repoWith({
      'settings.language': 'klingon',
      'settings.themeMode': 'neon',
    });
    expect(repo.load().language, AppLanguage.arabic);
    expect(repo.load().themeMode, ThemeMode.system);
  });

  test('clearAll removes every stored key', () async {
    final repo = await repoWith({'settings.onboardingCompleted': true});
    await repo.clearAll();
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getKeys(), isEmpty);
    expect(repo.load(), const AppSettings());
  });

  test('system language has no forced locale', () {
    const s = AppSettings(language: AppLanguage.system);
    expect(s.locale, isNull);
  });
}

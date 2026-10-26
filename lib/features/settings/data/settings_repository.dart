import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/shared_preferences_provider.dart';
import '../domain/app_settings.dart';

/// Persists [AppSettings] on the device. Stores preferences only — never
/// user content.
class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _kLanguage = 'settings.language';
  static const _kThemeMode = 'settings.themeMode';
  static const _kOnboarding = 'settings.onboardingCompleted';

  AppSettings load() {
    const defaults = AppSettings();
    return AppSettings(
      language: _byName(
        AppLanguage.values,
        _prefs.getString(_kLanguage),
        defaults.language,
      ),
      themeMode: _byName(
        ThemeMode.values,
        _prefs.getString(_kThemeMode),
        defaults.themeMode,
      ),
      onboardingCompleted:
          _prefs.getBool(_kOnboarding) ?? defaults.onboardingCompleted,
    );
  }

  Future<void> save(AppSettings settings) async {
    await _prefs.setString(_kLanguage, settings.language.name);
    await _prefs.setString(_kThemeMode, settings.themeMode.name);
    await _prefs.setBool(_kOnboarding, settings.onboardingCompleted);
  }

  /// Removes every value the app stored in preferences.
  Future<void> clearAll() => _prefs.clear();

  static T _byName<T extends Enum>(List<T> values, String? name, T fallback) {
    for (final v in values) {
      if (v.name == name) return v;
    }
    return fallback;
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(sharedPreferencesProvider)),
);

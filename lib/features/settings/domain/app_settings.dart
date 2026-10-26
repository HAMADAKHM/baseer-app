import 'package:flutter/material.dart';

/// User-chosen language. [system] follows the device, falling back to Arabic.
enum AppLanguage { system, arabic, english }

/// Immutable snapshot of the user's preferences.
@immutable
class AppSettings {
  const AppSettings({
    this.language = AppLanguage.arabic,
    this.themeMode = ThemeMode.system,
    this.onboardingCompleted = false,
  });

  final AppLanguage language;
  final ThemeMode themeMode;
  final bool onboardingCompleted;

  /// The explicit locale to force, or `null` to let the device decide.
  Locale? get locale => switch (language) {
    AppLanguage.arabic => const Locale('ar'),
    AppLanguage.english => const Locale('en'),
    AppLanguage.system => null,
  };

  AppSettings copyWith({
    AppLanguage? language,
    ThemeMode? themeMode,
    bool? onboardingCompleted,
  }) {
    return AppSettings(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.language == language &&
      other.themeMode == themeMode &&
      other.onboardingCompleted == onboardingCompleted;

  @override
  int get hashCode => Object.hash(language, themeMode, onboardingCompleted);
}

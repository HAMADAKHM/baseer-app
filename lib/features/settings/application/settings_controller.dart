import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/settings_repository.dart';
import '../domain/app_settings.dart';

/// Holds the current [AppSettings] and persists every change.
class SettingsController extends Notifier<AppSettings> {
  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  @override
  AppSettings build() => ref.watch(settingsRepositoryProvider).load();

  Future<void> setLanguage(AppLanguage language) =>
      _update(state.copyWith(language: language));

  Future<void> setThemeMode(ThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));

  Future<void> completeOnboarding() =>
      _update(state.copyWith(onboardingCompleted: true));

  /// Deletes all locally stored app data and resets to defaults.
  Future<void> deleteAllLocalData() async {
    await _repo.clearAll();
    state = const AppSettings();
  }

  Future<void> _update(AppSettings next) async {
    state = next;
    await _repo.save(next);
  }
}

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);

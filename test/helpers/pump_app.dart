import 'package:baseer/app.dart';
import 'package:baseer/core/storage/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Launches the full app with in-memory preferences and returns the
/// container so tests can inspect state.
Future<ProviderContainer> pumpBaseerApp(
  WidgetTester tester, {
  Map<String, Object> prefs = const {},
  double textScale = 1,
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final instance = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(instance)],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: const BaseerApp(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

const onboardedPrefs = <String, Object>{'settings.onboardingCompleted': true};

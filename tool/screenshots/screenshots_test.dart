// Renders preview PNGs of key screens with the real fonts.
// Run: flutter test tool/screenshots --update-goldens
// Output: tool/screenshots/out/*.png (not committed).
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test/helpers/pump_app.dart';

Future<void> _loadFont(String family, List<String> paths) async {
  final loader = FontLoader(family);
  for (final p in paths) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(p).readAsBytesSync())),
    );
  }
  await loader.load();
}

void main() {
  setUpAll(() async {
    const dir = 'assets/fonts/ibm_plex_sans_arabic';
    await _loadFont('IBMPlexSansArabic', [
      for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold'])
        '$dir/IBMPlexSansArabic-$w.ttf',
    ]);
    final flutterRoot = Platform.environment['FLUTTER_ROOT'] ?? '/opt/flutter';
    await _loadFont('MaterialIcons', [
      '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
    ]);
  });

  Future<void> shot(
    WidgetTester tester,
    String name,
    Map<String, Object> prefs, {
    String? tapTooltip,
  }) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await pumpBaseerApp(tester, prefs: prefs);
    if (tapTooltip != null) {
      await tester.tap(find.byTooltip(tapTooltip));
      await tester.pumpAndSettle();
    }
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('out/$name.png'),
    );
  }

  const done = {'settings.onboardingCompleted': true};

  testWidgets(
    'home ar light',
    (t) => shot(t, 'home_ar_light', {...done, 'settings.themeMode': 'light'}),
  );
  testWidgets(
    'home ar dark',
    (t) => shot(t, 'home_ar_dark', {...done, 'settings.themeMode': 'dark'}),
  );
  testWidgets(
    'home en light',
    (t) => shot(t, 'home_en_light', {
      ...done,
      'settings.themeMode': 'light',
      'settings.language': 'english',
    }),
  );
  testWidgets(
    'onboarding ar',
    (t) => shot(t, 'onboarding_ar_light', {'settings.themeMode': 'light'}),
  );
  testWidgets(
    'settings ar dark',
    (t) => shot(t, 'settings_ar_dark', {
      ...done,
      'settings.themeMode': 'dark',
    }, tapTooltip: 'الإعدادات'),
  );
}

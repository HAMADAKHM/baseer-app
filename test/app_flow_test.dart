import 'package:baseer/features/home/presentation/home_screen.dart';
import 'package:baseer/features/onboarding/presentation/onboarding_screen.dart';
import 'package:baseer/features/settings/application/settings_controller.dart';
import 'package:baseer/features/settings/domain/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/pump_app.dart';

void main() {
  TextDirection directionOf(WidgetTester tester, Type screen) =>
      Directionality.of(tester.element(find.byType(screen)));

  testWidgets('first launch shows Arabic RTL onboarding, then home', (
    tester,
  ) async {
    final container = await pumpBaseerApp(tester);

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(directionOf(tester, OnboardingScreen), TextDirection.rtl);
    expect(find.text('صوّر'), findsOneWidget);

    await tester.tap(find.byKey(const Key('onboardingNext')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('onboardingNext')));
    await tester.pumpAndSettle();
    expect(find.text('ابدأ'), findsOneWidget);
    await tester.tap(find.byKey(const Key('onboardingNext')));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(
      container.read(settingsControllerProvider).onboardingCompleted,
      isTrue,
    );
  });

  testWidgets('skip on onboarding also completes it', (tester) async {
    await pumpBaseerApp(tester);
    await tester.tap(find.text('تخطٍّ'));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('home shows every entry point in Arabic', (tester) async {
    await pumpBaseerApp(tester, prefs: onboardedPrefs);

    expect(directionOf(tester, HomeScreen), TextDirection.rtl);
    expect(find.text('بصير'), findsOneWidget);
    expect(find.byKey(const Key('captureButton')), findsOneWidget);
    expect(find.byKey(const Key('galleryButton')), findsOneWidget);
    for (final title in [
      'مسح مستند',
      'صورة إلى نص',
      'ترجمة',
      'اسأل بصير',
      'الفواتير والمصاريف',
      'التعلّم من الصور',
      'سجل العمليات',
      'الملفات المحفوظة',
    ]) {
      await tester.scrollUntilVisible(find.text(title), 100);
      expect(find.text(title), findsOneWidget, reason: title);
    }
  });

  testWidgets('unimplemented features are disabled and say so', (tester) async {
    await pumpBaseerApp(tester, prefs: onboardedPrefs);

    final capture = tester.widget<ButtonStyleButton>(
      find.byKey(const Key('captureButton')),
    );
    expect(capture.onPressed, isNull);
    expect(find.textContaining('قريبًا'), findsWidgets);

    await tester.tap(find.text('ترجمة'));
    await tester.pumpAndSettle();
    expect(find.text('«ترجمة» قيد التطوير ولم تُفعَّل بعد.'), findsOneWidget);
  });

  testWidgets('switching to English flips layout to LTR and persists', (
    tester,
  ) async {
    await pumpBaseerApp(tester, prefs: onboardedPrefs);

    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('lang_english')));
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(directionOf(tester, HomeScreen), TextDirection.ltr);
    expect(find.text('Capture. Understand. Get it done.'), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('settings.language'), 'english');
  });

  testWidgets('dark mode can be selected', (tester) async {
    await pumpBaseerApp(tester, prefs: onboardedPrefs);
    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('داكن'));
    await tester.pumpAndSettle();

    final ctx = tester.element(find.text('الإعدادات').first);
    expect(Theme.of(ctx).brightness, Brightness.dark);
  });

  testWidgets(
    'delete all data asks first, wipes storage, restarts onboarding',
    (tester) async {
      final container = await pumpBaseerApp(
        tester,
        prefs: {...onboardedPrefs, 'settings.themeMode': 'dark'},
      );
      await tester.tap(find.byTooltip('الإعدادات'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('الخصوصية والبيانات'));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('deleteAllData')));
      await tester.pumpAndSettle();
      // Cancelling keeps everything.
      await tester.tap(find.text('إلغاء'));
      await tester.pumpAndSettle();
      expect(
        container.read(settingsControllerProvider).onboardingCompleted,
        isTrue,
      );

      await tester.tap(find.byKey(const Key('deleteAllData')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('confirmDelete')));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(container.read(settingsControllerProvider), const AppSettings());
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getKeys(), isEmpty);
    },
  );

  testWidgets('subscription screen states purchases are not enabled', (
    tester,
  ) async {
    await pumpBaseerApp(tester, prefs: onboardedPrefs);
    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('الاشتراك'));
    await tester.pumpAndSettle();

    expect(find.text('Baseer Plus'), findsOneWidget);
    expect(find.text('الاشتراكات غير مفعّلة بعد'), findsOneWidget);
    // No purchase action exists yet.
    expect(find.byType(FilledButton), findsNothing);
  });

  for (final lang in ['arabic', 'english']) {
    testWidgets('home has no overflow at 2x text scale ($lang)', (
      tester,
    ) async {
      await pumpBaseerApp(
        tester,
        prefs: {...onboardedPrefs, 'settings.language': lang},
        textScale: 2,
      );
      expect(tester.takeException(), isNull);
      expect(find.byType(HomeScreen), findsOneWidget);
      await tester.scrollUntilVisible(find.byIcon(Icons.folder_rounded), 200);
      expect(tester.takeException(), isNull);
    });
  }
}

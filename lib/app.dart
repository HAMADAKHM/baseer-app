import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/application/settings_controller.dart';
import 'l10n/app_localizations.dart';

class BaseerApp extends ConsumerWidget {
  const BaseerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      locale: settings.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // "Device language": use English only if the device prefers it,
      // otherwise Arabic (the primary language).
      localeResolutionCallback: (device, supported) =>
          device?.languageCode == 'en'
          ? const Locale('en')
          : const Locale('ar'),
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}

import 'package:baseer/core/widgets/state_views.dart';
import 'package:baseer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child, Locale locale) => MaterialApp(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: Scaffold(body: child),
);

void main() {
  testWidgets('LoadingView shows localized text', (tester) async {
    await tester.pumpWidget(_host(const LoadingView(), const Locale('ar')));
    expect(find.text('جارٍ التحميل…'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ErrorView retry calls back', (tester) async {
    var retried = 0;
    await tester.pumpWidget(
      _host(ErrorView(onRetry: () => retried++), const Locale('en')),
    );
    expect(find.text('Something went wrong'), findsOneWidget);
    await tester.tap(find.text('Try again'));
    expect(retried, 1);
  });

  testWidgets('ErrorView without retry hides the button', (tester) async {
    await tester.pumpWidget(_host(const ErrorView(), const Locale('ar')));
    expect(find.text('إعادة المحاولة'), findsNothing);
  });

  testWidgets('OfflineView explains the situation in Arabic', (tester) async {
    await tester.pumpWidget(_host(const OfflineView(), const Locale('ar')));
    expect(find.text('لا يوجد اتصال بالإنترنت'), findsOneWidget);
  });
}

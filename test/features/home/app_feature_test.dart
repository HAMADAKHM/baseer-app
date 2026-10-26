import 'package:baseer/features/home/domain/app_feature.dart';
import 'package:baseer/l10n/app_localizations_ar.dart';
import 'package:baseer/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home lists all ten required entry points', () {
    expect(AppFeature.values, hasLength(10));
    expect(AppFeature.grid, hasLength(8));
    expect(AppFeature.grid, isNot(contains(AppFeature.capture)));
    expect(AppFeature.grid, isNot(contains(AppFeature.gallery)));
  });

  test('every feature has a non-empty title in both languages', () {
    for (final l10n in [AppLocalizationsAr(), AppLocalizationsEn()]) {
      for (final f in AppFeature.values) {
        expect(
          f.title(l10n),
          isNotEmpty,
          reason: '${f.name} ${l10n.localeName}',
        );
      }
      for (final f in AppFeature.grid) {
        expect(f.description(l10n), isNotEmpty);
      }
    }
  });

  test('no feature is marked available before it is implemented', () {
    // Phase 2 ships no working feature. Flip a flag only together with the
    // implementation and its tests.
    expect(AppFeature.values.where((f) => f.isAvailable), isEmpty);
  });
}

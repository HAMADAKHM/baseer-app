import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application display name
  ///
  /// In ar, this message translates to:
  /// **'بصير'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In ar, this message translates to:
  /// **'صوّر، افهم، أنجز'**
  String get tagline;

  /// No description provided for @homeGreeting.
  ///
  /// In ar, this message translates to:
  /// **'ماذا تريد أن تُنجز اليوم؟'**
  String get homeGreeting;

  /// No description provided for @captureButton.
  ///
  /// In ar, this message translates to:
  /// **'التقاط صورة'**
  String get captureButton;

  /// No description provided for @galleryButton.
  ///
  /// In ar, this message translates to:
  /// **'المعرض'**
  String get galleryButton;

  /// No description provided for @featureScanDocument.
  ///
  /// In ar, this message translates to:
  /// **'مسح مستند'**
  String get featureScanDocument;

  /// No description provided for @featureScanDocumentDesc.
  ///
  /// In ar, this message translates to:
  /// **'تصوير صفحة أو أكثر وتحسين وضوحها'**
  String get featureScanDocumentDesc;

  /// No description provided for @featureImageToText.
  ///
  /// In ar, this message translates to:
  /// **'صورة إلى نص'**
  String get featureImageToText;

  /// No description provided for @featureImageToTextDesc.
  ///
  /// In ar, this message translates to:
  /// **'استخراج النص العربي والإنجليزي'**
  String get featureImageToTextDesc;

  /// No description provided for @featureTranslate.
  ///
  /// In ar, this message translates to:
  /// **'ترجمة'**
  String get featureTranslate;

  /// No description provided for @featureTranslateDesc.
  ///
  /// In ar, this message translates to:
  /// **'ترجمة النص المستخرج من الصورة'**
  String get featureTranslateDesc;

  /// No description provided for @featureAskBaseer.
  ///
  /// In ar, this message translates to:
  /// **'اسأل بصير'**
  String get featureAskBaseer;

  /// No description provided for @featureAskBaseerDesc.
  ///
  /// In ar, this message translates to:
  /// **'اطرح سؤالًا عن محتوى الصورة'**
  String get featureAskBaseerDesc;

  /// No description provided for @featureInvoices.
  ///
  /// In ar, this message translates to:
  /// **'الفواتير والمصاريف'**
  String get featureInvoices;

  /// No description provided for @featureInvoicesDesc.
  ///
  /// In ar, this message translates to:
  /// **'استخراج بيانات الفاتورة ومراجعتها'**
  String get featureInvoicesDesc;

  /// No description provided for @featureLearning.
  ///
  /// In ar, this message translates to:
  /// **'التعلّم من الصور'**
  String get featureLearning;

  /// No description provided for @featureLearningDesc.
  ///
  /// In ar, this message translates to:
  /// **'شرح الأسئلة الدراسية خطوة بخطوة'**
  String get featureLearningDesc;

  /// No description provided for @featureHistory.
  ///
  /// In ar, this message translates to:
  /// **'سجل العمليات'**
  String get featureHistory;

  /// No description provided for @featureHistoryDesc.
  ///
  /// In ar, this message translates to:
  /// **'كل ما حلّلته سابقًا'**
  String get featureHistoryDesc;

  /// No description provided for @featureSavedFiles.
  ///
  /// In ar, this message translates to:
  /// **'الملفات المحفوظة'**
  String get featureSavedFiles;

  /// No description provided for @featureSavedFilesDesc.
  ///
  /// In ar, this message translates to:
  /// **'مستندات Word وPDF التي أنشأتها'**
  String get featureSavedFilesDesc;

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريبًا'**
  String get comingSoon;

  /// No description provided for @featureNotReady.
  ///
  /// In ar, this message translates to:
  /// **'«{feature}» قيد التطوير ولم تُفعَّل بعد.'**
  String featureNotReady(String feature);

  /// No description provided for @featureNotReadySemantics.
  ///
  /// In ar, this message translates to:
  /// **'{feature}، غير متاحة بعد'**
  String featureNotReadySemantics(String feature);

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @languageArabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageEnglish.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSystem.
  ///
  /// In ar, this message translates to:
  /// **'لغة الجهاز'**
  String get languageSystem;

  /// No description provided for @appearance.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get appearance;

  /// No description provided for @themeSystem.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ar, this message translates to:
  /// **'فاتح'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ar, this message translates to:
  /// **'داكن'**
  String get themeDark;

  /// No description provided for @privacyAndData.
  ///
  /// In ar, this message translates to:
  /// **'الخصوصية والبيانات'**
  String get privacyAndData;

  /// No description provided for @privacyAndDataDesc.
  ///
  /// In ar, this message translates to:
  /// **'ما يُحفظ وأين يُعالج، وحذف البيانات'**
  String get privacyAndDataDesc;

  /// No description provided for @subscription.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراك'**
  String get subscription;

  /// No description provided for @subscriptionDesc.
  ///
  /// In ar, this message translates to:
  /// **'الخطة المجانية وBaseer Plus'**
  String get subscriptionDesc;

  /// No description provided for @privacyCurrentTitle.
  ///
  /// In ar, this message translates to:
  /// **'ما يحفظه التطبيق الآن'**
  String get privacyCurrentTitle;

  /// No description provided for @privacyCurrentBody.
  ///
  /// In ar, this message translates to:
  /// **'في هذا الإصدار يحفظ بصير إعداداتك فقط (اللغة، المظهر، وإتمام شاشة التعريف) على جهازك. لا تُحفظ صور أو نصوص، ولا يُرسل أي شيء إلى خوادمنا.'**
  String get privacyCurrentBody;

  /// No description provided for @privacyPrinciplesTitle.
  ///
  /// In ar, this message translates to:
  /// **'مبادئنا'**
  String get privacyPrinciplesTitle;

  /// No description provided for @privacyPrinciple1.
  ///
  /// In ar, this message translates to:
  /// **'نطلب صلاحية الكاميرا أو الصور فقط عند استخدام ميزة تحتاجها.'**
  String get privacyPrinciple1;

  /// No description provided for @privacyPrinciple2.
  ///
  /// In ar, this message translates to:
  /// **'نوضّح قبل كل عملية هل تتم على جهازك أم تُرسل إلى الخادم.'**
  String get privacyPrinciple2;

  /// No description provided for @privacyPrinciple3.
  ///
  /// In ar, this message translates to:
  /// **'لا نستخدم صورك أو مستنداتك لتدريب النماذج.'**
  String get privacyPrinciple3;

  /// No description provided for @privacyPrinciple4.
  ///
  /// In ar, this message translates to:
  /// **'لا نجمع موقعك الجغرافي.'**
  String get privacyPrinciple4;

  /// No description provided for @privacyPrinciple5.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك حذف بياناتك في أي وقت.'**
  String get privacyPrinciple5;

  /// No description provided for @deleteAllData.
  ///
  /// In ar, this message translates to:
  /// **'حذف جميع البيانات من الجهاز'**
  String get deleteAllData;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف جميع البيانات؟'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmBody.
  ///
  /// In ar, this message translates to:
  /// **'سيُحذف كل ما يحفظه بصير على هذا الجهاز وتعود الإعدادات إلى وضعها الافتراضي. لا يمكن التراجع عن ذلك.'**
  String get deleteConfirmBody;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @dataDeleted.
  ///
  /// In ar, this message translates to:
  /// **'حُذفت جميع البيانات المحلية.'**
  String get dataDeleted;

  /// No description provided for @planFree.
  ///
  /// In ar, this message translates to:
  /// **'المجانية'**
  String get planFree;

  /// No description provided for @planPlus.
  ///
  /// In ar, this message translates to:
  /// **'Baseer Plus'**
  String get planPlus;

  /// No description provided for @planFreeFeatures.
  ///
  /// In ar, this message translates to:
  /// **'مسح أساسي للمستندات\nنسخ النص\nحصة محدودة من التحليلات الذكية'**
  String get planFreeFeatures;

  /// No description provided for @planPlusFeatures.
  ///
  /// In ar, this message translates to:
  /// **'حصة أكبر من التحليلات الذكية\nمستندات متعددة الصفحات\nتصدير متقدم وفواتير وجداول\nتلخيص وترجمة متقدمة'**
  String get planPlusFeatures;

  /// No description provided for @subscriptionNotAvailable.
  ///
  /// In ar, this message translates to:
  /// **'الاشتراكات غير مفعّلة بعد'**
  String get subscriptionNotAvailable;

  /// No description provided for @subscriptionNotAvailableBody.
  ///
  /// In ar, this message translates to:
  /// **'لن يُطلب منك أي دفع حاليًا. عند تفعيل الاشتراك سيتم عبر متجر Google Play أو App Store فقط، مع عرض السعر والمدة وشروط التجديد بوضوح قبل الموافقة.'**
  String get subscriptionNotAvailableBody;

  /// No description provided for @onboardingTitle1.
  ///
  /// In ar, this message translates to:
  /// **'صوّر'**
  String get onboardingTitle1;

  /// No description provided for @onboardingBody1.
  ///
  /// In ar, this message translates to:
  /// **'التقط صورة لمستند أو فاتورة أو سؤال دراسي.'**
  String get onboardingBody1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In ar, this message translates to:
  /// **'افهم'**
  String get onboardingTitle2;

  /// No description provided for @onboardingBody2.
  ///
  /// In ar, this message translates to:
  /// **'يستخرج بصير النص ويترجمه ويشرحه، ويخبرك بوضوح عندما لا يكون متأكدًا.'**
  String get onboardingBody2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In ar, this message translates to:
  /// **'أنجز'**
  String get onboardingTitle3;

  /// No description provided for @onboardingBody3.
  ///
  /// In ar, this message translates to:
  /// **'صدّر النتائج إلى Word أو PDF واحفظها. صورك تبقى تحت سيطرتك.'**
  String get onboardingBody3;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In ar, this message translates to:
  /// **'تخطٍّ'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ'**
  String get getStarted;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحميل…'**
  String get loading;

  /// No description provided for @errorTitle.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ'**
  String get errorTitle;

  /// No description provided for @errorGeneric.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إتمام العملية. حاول مرة أخرى.'**
  String get errorGeneric;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @offlineTitle.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت'**
  String get offlineTitle;

  /// No description provided for @offlineBody.
  ///
  /// In ar, this message translates to:
  /// **'هذه العملية تحتاج إلى اتصال. الميزات المحلية ما زالت متاحة.'**
  String get offlineBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

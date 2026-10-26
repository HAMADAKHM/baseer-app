// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Baseer';

  @override
  String get tagline => 'Capture. Understand. Get it done.';

  @override
  String get homeGreeting => 'What would you like to get done today?';

  @override
  String get captureButton => 'Take a photo';

  @override
  String get galleryButton => 'Gallery';

  @override
  String get featureScanDocument => 'Scan document';

  @override
  String get featureScanDocumentDesc =>
      'Capture one or more pages and enhance them';

  @override
  String get featureImageToText => 'Image to text';

  @override
  String get featureImageToTextDesc => 'Extract Arabic and English text';

  @override
  String get featureTranslate => 'Translate';

  @override
  String get featureTranslateDesc => 'Translate text found in an image';

  @override
  String get featureAskBaseer => 'Ask Baseer';

  @override
  String get featureAskBaseerDesc => 'Ask a question about the image';

  @override
  String get featureInvoices => 'Invoices & expenses';

  @override
  String get featureInvoicesDesc => 'Extract and review invoice details';

  @override
  String get featureLearning => 'Learn from images';

  @override
  String get featureLearningDesc => 'Step-by-step help with study questions';

  @override
  String get featureHistory => 'History';

  @override
  String get featureHistoryDesc => 'Everything you analyzed before';

  @override
  String get featureSavedFiles => 'Saved files';

  @override
  String get featureSavedFilesDesc => 'Word and PDF documents you created';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String featureNotReady(String feature) {
    return '“$feature” is under development and not enabled yet.';
  }

  @override
  String featureNotReadySemantics(String feature) {
    return '$feature, not available yet';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSystem => 'Device language';

  @override
  String get appearance => 'Appearance';

  @override
  String get themeSystem => 'Auto';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get privacyAndData => 'Privacy & data';

  @override
  String get privacyAndDataDesc =>
      'What is stored, where it is processed, and deleting data';

  @override
  String get subscription => 'Subscription';

  @override
  String get subscriptionDesc => 'Free plan and Baseer Plus';

  @override
  String get privacyCurrentTitle => 'What the app stores today';

  @override
  String get privacyCurrentBody =>
      'In this version Baseer only stores your settings (language, appearance, and onboarding completion) on your device. No images or text are stored, and nothing is sent to our servers.';

  @override
  String get privacyPrinciplesTitle => 'Our principles';

  @override
  String get privacyPrinciple1 =>
      'We ask for camera or photo access only when you use a feature that needs it.';

  @override
  String get privacyPrinciple2 =>
      'Before each operation we tell you whether it runs on your device or is sent to the server.';

  @override
  String get privacyPrinciple3 =>
      'We never use your images or documents to train models.';

  @override
  String get privacyPrinciple4 => 'We do not collect your location.';

  @override
  String get privacyPrinciple5 => 'You can delete your data at any time.';

  @override
  String get deleteAllData => 'Delete all data on this device';

  @override
  String get deleteConfirmTitle => 'Delete all data?';

  @override
  String get deleteConfirmBody =>
      'Everything Baseer stores on this device will be deleted and settings will be reset. This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get dataDeleted => 'All local data was deleted.';

  @override
  String get planFree => 'Free';

  @override
  String get planPlus => 'Baseer Plus';

  @override
  String get planFreeFeatures =>
      'Basic document scanning\nCopy text\nLimited smart analyses';

  @override
  String get planPlusFeatures =>
      'More smart analyses\nMulti-page documents\nAdvanced export, invoices and tables\nAdvanced summaries and translation';

  @override
  String get subscriptionNotAvailable => 'Subscriptions are not enabled yet';

  @override
  String get subscriptionNotAvailableBody =>
      'You will not be asked to pay anything right now. When subscriptions launch they will go through Google Play or the App Store only, with the price, period and renewal terms shown clearly before you agree.';

  @override
  String get onboardingTitle1 => 'Capture';

  @override
  String get onboardingBody1 =>
      'Take a photo of a document, an invoice or a study question.';

  @override
  String get onboardingTitle2 => 'Understand';

  @override
  String get onboardingBody2 =>
      'Baseer extracts, translates and explains the text — and tells you clearly when it is not sure.';

  @override
  String get onboardingTitle3 => 'Get it done';

  @override
  String get onboardingBody3 =>
      'Export results to Word or PDF and keep them. Your photos stay under your control.';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get started';

  @override
  String get loading => 'Loading…';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorGeneric =>
      'The operation could not be completed. Please try again.';

  @override
  String get retry => 'Try again';

  @override
  String get offlineTitle => 'No internet connection';

  @override
  String get offlineBody =>
      'This action needs a connection. On-device features are still available.';
}

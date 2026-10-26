// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'بصير';

  @override
  String get tagline => 'صوّر، افهم، أنجز';

  @override
  String get homeGreeting => 'ماذا تريد أن تُنجز اليوم؟';

  @override
  String get captureButton => 'التقاط صورة';

  @override
  String get galleryButton => 'المعرض';

  @override
  String get featureScanDocument => 'مسح مستند';

  @override
  String get featureScanDocumentDesc => 'تصوير صفحة أو أكثر وتحسين وضوحها';

  @override
  String get featureImageToText => 'صورة إلى نص';

  @override
  String get featureImageToTextDesc => 'استخراج النص العربي والإنجليزي';

  @override
  String get featureTranslate => 'ترجمة';

  @override
  String get featureTranslateDesc => 'ترجمة النص المستخرج من الصورة';

  @override
  String get featureAskBaseer => 'اسأل بصير';

  @override
  String get featureAskBaseerDesc => 'اطرح سؤالًا عن محتوى الصورة';

  @override
  String get featureInvoices => 'الفواتير والمصاريف';

  @override
  String get featureInvoicesDesc => 'استخراج بيانات الفاتورة ومراجعتها';

  @override
  String get featureLearning => 'التعلّم من الصور';

  @override
  String get featureLearningDesc => 'شرح الأسئلة الدراسية خطوة بخطوة';

  @override
  String get featureHistory => 'سجل العمليات';

  @override
  String get featureHistoryDesc => 'كل ما حلّلته سابقًا';

  @override
  String get featureSavedFiles => 'الملفات المحفوظة';

  @override
  String get featureSavedFilesDesc => 'مستندات Word وPDF التي أنشأتها';

  @override
  String get comingSoon => 'قريبًا';

  @override
  String featureNotReady(String feature) {
    return '«$feature» قيد التطوير ولم تُفعَّل بعد.';
  }

  @override
  String featureNotReadySemantics(String feature) {
    return '$feature، غير متاحة بعد';
  }

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSystem => 'لغة الجهاز';

  @override
  String get appearance => 'المظهر';

  @override
  String get themeSystem => 'تلقائي';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get privacyAndData => 'الخصوصية والبيانات';

  @override
  String get privacyAndDataDesc => 'ما يُحفظ وأين يُعالج، وحذف البيانات';

  @override
  String get subscription => 'الاشتراك';

  @override
  String get subscriptionDesc => 'الخطة المجانية وBaseer Plus';

  @override
  String get privacyCurrentTitle => 'ما يحفظه التطبيق الآن';

  @override
  String get privacyCurrentBody =>
      'في هذا الإصدار يحفظ بصير إعداداتك فقط (اللغة، المظهر، وإتمام شاشة التعريف) على جهازك. لا تُحفظ صور أو نصوص، ولا يُرسل أي شيء إلى خوادمنا.';

  @override
  String get privacyPrinciplesTitle => 'مبادئنا';

  @override
  String get privacyPrinciple1 =>
      'نطلب صلاحية الكاميرا أو الصور فقط عند استخدام ميزة تحتاجها.';

  @override
  String get privacyPrinciple2 =>
      'نوضّح قبل كل عملية هل تتم على جهازك أم تُرسل إلى الخادم.';

  @override
  String get privacyPrinciple3 => 'لا نستخدم صورك أو مستنداتك لتدريب النماذج.';

  @override
  String get privacyPrinciple4 => 'لا نجمع موقعك الجغرافي.';

  @override
  String get privacyPrinciple5 => 'يمكنك حذف بياناتك في أي وقت.';

  @override
  String get deleteAllData => 'حذف جميع البيانات من الجهاز';

  @override
  String get deleteConfirmTitle => 'حذف جميع البيانات؟';

  @override
  String get deleteConfirmBody =>
      'سيُحذف كل ما يحفظه بصير على هذا الجهاز وتعود الإعدادات إلى وضعها الافتراضي. لا يمكن التراجع عن ذلك.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get dataDeleted => 'حُذفت جميع البيانات المحلية.';

  @override
  String get planFree => 'المجانية';

  @override
  String get planPlus => 'Baseer Plus';

  @override
  String get planFreeFeatures =>
      'مسح أساسي للمستندات\nنسخ النص\nحصة محدودة من التحليلات الذكية';

  @override
  String get planPlusFeatures =>
      'حصة أكبر من التحليلات الذكية\nمستندات متعددة الصفحات\nتصدير متقدم وفواتير وجداول\nتلخيص وترجمة متقدمة';

  @override
  String get subscriptionNotAvailable => 'الاشتراكات غير مفعّلة بعد';

  @override
  String get subscriptionNotAvailableBody =>
      'لن يُطلب منك أي دفع حاليًا. عند تفعيل الاشتراك سيتم عبر متجر Google Play أو App Store فقط، مع عرض السعر والمدة وشروط التجديد بوضوح قبل الموافقة.';

  @override
  String get onboardingTitle1 => 'صوّر';

  @override
  String get onboardingBody1 => 'التقط صورة لمستند أو فاتورة أو سؤال دراسي.';

  @override
  String get onboardingTitle2 => 'افهم';

  @override
  String get onboardingBody2 =>
      'يستخرج بصير النص ويترجمه ويشرحه، ويخبرك بوضوح عندما لا يكون متأكدًا.';

  @override
  String get onboardingTitle3 => 'أنجز';

  @override
  String get onboardingBody3 =>
      'صدّر النتائج إلى Word أو PDF واحفظها. صورك تبقى تحت سيطرتك.';

  @override
  String get next => 'التالي';

  @override
  String get skip => 'تخطٍّ';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get errorTitle => 'حدث خطأ';

  @override
  String get errorGeneric => 'تعذّر إتمام العملية. حاول مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get offlineTitle => 'لا يوجد اتصال بالإنترنت';

  @override
  String get offlineBody =>
      'هذه العملية تحتاج إلى اتصال. الميزات المحلية ما زالت متاحة.';
}

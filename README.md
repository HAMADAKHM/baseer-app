# BASEER | بصير

> صوّر، افهم، أنجز

تطبيق كاميرا ذكية لنظامي Android وiOS يحوّل ما تراه الكاميرا إلى نص ومستندات وإجابات. مبني بـ Flutter، والعربية لغته الأساسية (RTL) مع دعم الإنجليزية.

## الحالة الحالية: المرحلة الثانية (الأساس)

| الجزء | الحالة |
|---|---|
| هيكل المشروع، Riverpod، go_router | ✅ منفّذ |
| الثيم الفاتح والداكن، خط IBM Plex Sans Arabic | ✅ منفّذ |
| العربية RTL والإنجليزية LTR مع التبديل من الإعدادات | ✅ منفّذ ومختبر |
| شاشة التعريف، الرئيسية، الإعدادات، الخصوصية، الاشتراك | ✅ منفّذة |
| حذف جميع البيانات المحلية | ✅ منفّذ ومختبر |
| الكاميرا، OCR، التصدير، الذكاء الاصطناعي، الاشتراكات | ⏳ **غير منفّذة بعد**، وتظهر في الواجهة معطّلة بشارة «قريبًا» |

لا توجد في التطبيق أي نتائج وهمية. كل ميزة تبقى معطّلة (`AppFeature.isAvailable = false`) حتى تُنفَّذ وتُختبر فعليًا.

## التشغيل

```bash
./scripts/setup_env.sh && source ~/.baseer_env   # Linux: يثبّت Flutter 3.47.8 وAndroid SDK إن لم يكونا موجودين
flutter pub get
flutter analyze
flutter test
flutter run                       # على جهاز أو محاكٍ
flutter build apk --debug         # Android
flutter build ios                 # يتطلب macOS + Xcode
```

معاينة الشاشات بالخط الحقيقي (تُحفظ في `tool/screenshots/out/` ولا تُرفع إلى Git):

```bash
flutter test tool/screenshots --update-goldens
```

## الوثائق

- [ARCHITECTURE.md](ARCHITECTURE.md): البنية واختيار إدارة الحالة
- [SECURITY.md](SECURITY.md): الخصوصية والأمان وإدارة المفاتيح
- [TESTING.md](TESTING.md): الاختبارات وطريقة تشغيلها
- [ROADMAP.md](ROADMAP.md): المراحل
- [SETUP_REPORT.md](SETUP_REPORT.md): تقرير فحص البيئة

## المعرّفات

- Android applicationId / iOS bundle id: `com.hamadakhm.baseer`

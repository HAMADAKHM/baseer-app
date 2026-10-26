# ARCHITECTURE — بنية بصير

## المبادئ

1. **التقسيم حسب الميزة** (feature-first)، وداخل كل ميزة طبقات منفصلة.
2. **الواجهة لا تعرف مصدر البيانات.** الشاشات تقرأ الحالة من Riverpod فقط.
3. **مزوّدو الخدمات قابلون للاستبدال.** OCR والترجمة والذكاء الاصطناعي تُعرَّف كواجهات (interfaces) في `domain`، والتطبيقات الفعلية في `data`. تغيير المزوّد لا يتطلب تعديل الواجهة.
4. **لا أسرار في التطبيق.** أي مفتاح API يبقى في الـ Backend (المرحلة السابعة).

## الهيكل

```
lib/
├── main.dart                 # تهيئة SharedPreferences ثم ProviderScope
├── app.dart                  # MaterialApp.router: الثيم واللغة والمسارات
├── l10n/                     # app_ar.arb (القالب) + app_en.arb → توليد تلقائي
├── core/
│   ├── router/               # go_router + إعادة التوجيه لشاشة التعريف
│   ├── theme/                # الألوان والثيم الفاتح والداكن
│   ├── storage/              # مزوّد SharedPreferences
│   └── widgets/              # LoadingView / ErrorView / OfflineView
└── features/
    ├── home/        domain/app_feature.dart (كتالوج الميزات + حالة التفعيل), presentation/
    ├── onboarding/  presentation/
    ├── settings/    domain/ data/ application/ presentation/
    ├── privacy/     presentation/ (عرض السياسة + حذف البيانات)
    └── subscription/presentation/ (عرض الخطط؛ لا شراء بعد)
```

الطبقات داخل كل ميزة:

| الطبقة | المسؤولية |
|---|---|
| `domain` | نماذج غير قابلة للتعديل وواجهات المزوّدين، دون أي اعتماد على Flutter UI أو التخزين |
| `data` | التنفيذ الفعلي: التخزين المحلي، ML Kit، استدعاءات الـ Backend |
| `application` | منطق الأعمال: Riverpod `Notifier`s |
| `presentation` | الشاشات والـ widgets |

الميزات القادمة (camera, ocr, export, ai, invoices, learning, history, files, billing, quota) ستتبع الهيكل نفسه.

## إدارة الحالة: Riverpod 3

اخترنا **Riverpod** بدلًا من Bloc للأسباب التالية:

- **حقن الاعتماديات مدمج**: يمكن استبدال مزوّد OCR أو الذكاء الاصطناعي في الاختبارات أو الإنتاج عبر `overrides` دون مكتبة DI إضافية. هذا ضروري لمتطلب «المزوّد قابل للتغيير».
- **قابلية الاختبار**: `ProviderContainer` يتيح اختبار المنطق دون واجهة (راجع `test/features/settings/settings_controller_test.dart`).
- **كود أقل** من Bloc للحالات البسيطة (إعدادات، حصص)، مع دعم جيد للحالات غير المتزامنة (`AsyncNotifier`) التي سنحتاجها في OCR والتحليل.
- **أمان وقت الترجمة**: لا يعتمد على `BuildContext` لقراءة الحالة.

Bloc خيار ممتاز أيضًا، لكنه يضيف مراسم (events/states) لا نحتاجها في أغلب شاشات التطبيق.

## التنقل

`go_router` مع `redirect`: إن لم تكتمل شاشة التعريف يُحوَّل المستخدم إليها. المسارات معرّفة في `AppRoutes`.

## اللغة والاتجاه

- `l10n.yaml` + ملفات ARB، ويولّد Flutter `AppLocalizations`.
- العربية هي الافتراضية. خيار «لغة الجهاز» يختار الإنجليزية فقط إن كان الجهاز إنجليزيًا، وإلا فالعربية.
- الاتجاه (RTL/LTR) يُحدَّد تلقائيًا من اللغة. نستخدم `EdgeInsetsDirectional` و`AlignmentDirectional` بدل left/right.
- اسم التطبيق على Android مترجم (`values/strings.xml`، `values-ar/strings.xml`). على iOS أُضيفت `CFBundleLocalizations`، أما ترجمة اسم الأيقونة على iOS فتحتاج `InfoPlist.strings` عبر Xcode (مرحلة لاحقة).

## تفعيل الميزات

`AppFeature` (في `features/home/domain/app_feature.dart`) هو المصدر الوحيد لحالة كل ميزة. الميزة غير المفعّلة:
- تظهر باهتة مع شارة «قريبًا».
- يعلن قارئ الشاشة أنها «غير متاحة بعد».
- عند لمسها تظهر رسالة توضّح أنها قيد التطوير.

اختبار `no feature is marked available before it is implemented` يمنع تفعيل ميزة دون تحديثه بوعي.

## الخطط المعمارية للمراحل القادمة (غير منفّذة)

- **OCR**: واجهة `TextRecognizer` بتنفيذ محلي أولًا. يُتحقق في المرحلة الثالثة من دعم ML Kit للعربية قبل اعتماده.
- **AI**: واجهة `AiProvider` في التطبيق تتصل **بالـ Backend فقط**، والـ Backend هو من يختار المزوّد. لم يُختر مزوّد بعد: ستُجرى مقارنة للجودة والتكلفة والخصوصية ودعم العربية.
- **الحصص**: تُفرض على الخادم، والعرض في التطبيق للمعلومة فقط.
- **الاشتراكات**: Google Play Billing وStoreKit عبر مكتبة رسمية، مع تحقق من الإيصالات على الخادم.

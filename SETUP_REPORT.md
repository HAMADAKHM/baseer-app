# SETUP_REPORT — BASEER | بصير

> المرحلة الأولى: فحص بيئة العمل
> تاريخ الفحص: 2026-10-26
> كل القيم أدناه ناتجة عن أوامر نُفّذت فعليًا في هذه البيئة. لم يُثبَّت أي برنامج ولم يُحذف أي ملف.

---

## 1. طبيعة البيئة (مهم جدًا)

| البند | النتيجة |
|---|---|
| نوع البيئة | حاوية سحابية مؤقتة (Claude Code Remote)، وليست جهاز المستخدم |
| نظام التشغيل | Ubuntu 24.04.5 LTS، Linux kernel 6.18، x86_64 |
| المعالج / الذاكرة | 4 أنوية / 15 GiB RAM |
| المساحة المتاحة | نحو 31 GB قابلة للكتابة |
| المجلد الحالي `/home/user` | **فارغ تمامًا**: لا يوجد مشروع سابق ولا مستودع Git |
| استمرارية الملفات | **الحاوية مؤقتة**: تُحذف الملفات عند انتهاء الجلسة ما لم تُرفع إلى مستودع Git بعيد (GitHub) |
| المحاكاة الافتراضية `/dev/kvm` | **غير متوفرة**، لذلك لا يمكن تشغيل محاكي Android هنا |
| الأجهزة الموصولة | لا توجد (حاوية سحابية، ولا يتوفر USB أو أجهزة) |
| macOS / Xcode | **غير متاح**، لأن البيئة Linux |

---

## 2. البرامج المتوفرة

| الأداة | الحالة | الإصدار |
|---|---|---|
| Git | ✅ متوفر | 2.43.0 |
| Java JDK | ✅ متوفر | OpenJDK 21.0.12 (`JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64`) |
| Gradle (مستقل) | ✅ متوفر | 8.14.3 (مشروع Flutter يستخدم Gradle Wrapper الخاص به على أي حال) |
| Node.js / npm | ✅ متوفر | v22.22.0 (مفيد للـ Backend مثل Cloud Functions) |
| Python | ✅ متوفر | 3.13.17 (مفيد لتوليد صور الاختبار المصطنعة) |
| Docker | ✅ متوفر | 29.9.2 (مفيد لتشغيل الـ Backend محليًا واختباره) |
| gcloud / gh | ✅ متوفر | أدوات Google Cloud وGitHub CLI |
| unzip, xz, clang, cmake, ninja, pkg-config | ✅ متوفرة | أدوات مطلوبة لاستخراج Flutter وبنائه |

## 3. البرامج الناقصة

| الأداة | الحالة | الأثر |
|---|---|---|
| Flutter SDK | ❌ غير مثبت | لا يمكن إنشاء المشروع أو بناؤه قبل تثبيته |
| Dart SDK | ❌ غير مثبت | يأتي مضمّنًا مع Flutter، فلا يحتاج تثبيتًا منفصلًا |
| Android SDK (cmdline-tools, platform-tools, platforms, build-tools) | ❌ غير مثبت | ضروري لبناء APK/AAB |
| adb / emulator | ❌ غير مثبت | لا فائدة من المحاكي هنا لغياب KVM |
| Xcode / CocoaPods | ❌ غير متاح | **لا يمكن بناء iOS على Linux إطلاقًا** |
| Firebase CLI | ❌ غير مثبت | يُقرَّر لاحقًا حسب اختيار الـ Backend (المرحلة السابعة) |
| libgtk-3-dev | ❌ غير مثبت | يلزم فقط لبناء نسخة Linux سطح المكتب، وليس مطلوبًا لهدفنا |

## 4. فحص الوصول للشبكة (من خلال الـ proxy)

| الوجهة | النتيجة |
|---|---|
| storage.googleapis.com (أرشيف Flutter) | ✅ 200 |
| pub.dev (حزم Dart) | ✅ 200 |
| dl.google.com (Android SDK) | ✅ 200 |
| maven.google.com / Maven Central | ✅ 200 |
| github.com (git) | ✅ `git ls-remote` على مستودع Flutter نجح |

**أحدث إصدارات متاحة وقت الفحص:**
- Flutter stable: **3.47.8** (Dart 3.13.7)، تاريخ الإصدار 2026-10-23
- Android cmdline-tools: `commandlinetools-linux-16111833_latest.zip`
- Android platforms: حتى `android-37`؛ build-tools حتى `37.0.0`

---

## 5. المشكلات المتوقعة

1. **iOS لا يُبنى هنا.** بناء iOS وتوقيعه ورفعه إلى TestFlight يتطلب macOS وXcode. الخيارات:
   - جهاز Mac لديك، وهو الأفضل لاختبار الكاميرا والصلاحيات على iPhone حقيقي.
   - خدمة CI سحابية تعمل بـ macOS، مثل GitHub Actions (macOS runners) أو Codemagic. يلزم حساب Apple Developer (مدفوع سنويًا) للتوقيع والنشر.
   - الكود سيبقى مشتركًا. يمكن هنا كتابة كود iOS وإعداداته (Info.plist، الصلاحيات) لكن **لا يمكن التحقق من بنائه هنا**، وسأذكر ذلك صراحة في كل مرحلة.
2. **لا يوجد محاكي Android ولا جهاز.** يمكن هنا تنفيذ `flutter analyze` واختبارات الوحدات والواجهات (`flutter test`) وبناء APK فعلي. أما الكاميرا وOCR عبر ML Kit والصلاحيات الحقيقية واختبارات `integration_test` على الجهاز فتحتاج هاتف Android حقيقيًا لديك، أو محاكيًا على جهازك، أو خدمة مثل Firebase Test Lab.
3. **الحاوية مؤقتة.** يجب إنشاء مستودع GitHub (خاص) ورفع العمل إليه بانتظام، وإلا ضاع عند انتهاء الجلسة. كذلك ستحتاج كل جلسة جديدة إلى إعادة تثبيت Flutter وAndroid SDK. الحل: سكربت إعداد (setup script) لبيئة الجلسة أو SessionStart hook.
4. **JDK 21.** متوافق مع إصدارات Flutter وAndroid Gradle Plugin الحديثة، وسيُتحقق من ذلك فعليًا عبر `flutter doctor` بعد التثبيت.
5. **رخص Android SDK.** يتطلب `sdkmanager --licenses` قبول الرخص، وهذا قرار يعود إليك.
6. **الاشتراكات والتجربة المجانية.** لم تُفحص سياسات المتاجر بعد، وسيكون ذلك قبل المرحلة الثامنة كما طلبت. اختبار الاشتراكات يحتاج حسابات Google Play Console وApple Developer وتطبيقًا مرفوعًا على مسار اختبار داخلي، ولا يمكن محاكاته بالكامل هنا.
7. **OCR العربي محليًا.** يجب التحقق في المرحلة الثالثة من دعم Google ML Kit Text Recognition للأحرف العربية (دعمه التاريخي يشمل اللاتينية والصينية واليابانية والكورية والديفاناغارية). إن لم يكن مدعومًا فسنحتاج بديلًا (Tesseract محليًا، أو خدمة سحابية عبر الـ Backend) مع توضيح الفرق للمستخدم. لن أفترض النتيجة قبل الفحص.

---

## 5.1 تحديث 2026-10-26: نتيجة التثبيت (بعد موافقة المستخدم)

| البند | النتيجة الفعلية |
|---|---|
| Flutter | ✅ 3.47.8 stable في `/opt/flutter` (Dart 3.13.7)، والتحليلات معطّلة |
| Android SDK | ✅ في `/opt/android-sdk`: cmdline-tools، platform-tools، `platforms;android-36`، `build-tools;36.1.0`، وجميع الرخص مقبولة |
| `flutter doctor -v` | ✅ Flutter ✅ Android toolchain ✅ Network؛ ⚠️ No devices (متوقع، لا يوجد KVM أو جهاز) |
| دعم web وlinux-desktop | معطّل عمدًا (`flutter config`) لأن الهدف Android وiOS |
| متغيرات البيئة | أُضيفت إلى `~/.bashrc` (ستُفقد عند انتهاء الحاوية) |
| مستودع GitHub `baseer-app` | ❌ **لم يُنشأ**: الجلسة لا تملك صلاحية إنشاء مستودعات جديدة (HTTP 403). على المستخدم إنشاؤه يدويًا |
| Git محلي | ✅ أُنشئ مستودع محلي في `/home/user/baseer` (فرع `main`) بانتظار ربطه بالمستودع البعيد |

## 6. الخطوة التالية اللازمة (تحتاج موافقتك)

### الخيار المقترح (أ): تثبيت الأدوات في هذه البيئة السحابية

يثبّت Flutter وAndroid SDK داخل الحاوية (نحو 4–6 GB) دون أي تكلفة مالية ودون مفاتيح API:

```bash
# 1) Flutter 3.47.8 stable
sudo mkdir -p /opt && cd /opt
curl -fLO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.47.8-stable.tar.xz
tar -xf flutter_linux_3.47.8-stable.tar.xz && rm flutter_linux_3.47.8-stable.tar.xz
git config --global --add safe.directory /opt/flutter
export PATH="/opt/flutter/bin:$PATH"
flutter --disable-analytics
flutter --version

# 2) Android SDK command-line tools
export ANDROID_HOME=/opt/android-sdk
mkdir -p $ANDROID_HOME/cmdline-tools && cd $ANDROID_HOME/cmdline-tools
curl -fLO https://dl.google.com/android/repository/commandlinetools-linux-16111833_latest.zip
unzip -q commandlinetools-linux-16111833_latest.zip && mv cmdline-tools latest && rm commandlinetools-linux-16111833_latest.zip
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# 3) حزم SDK: تُحدَّد الإصدارات النهائية حسب ما يطلبه flutter doctor
sdkmanager --licenses            # قبول الرخص (قرارك)
sdkmanager "platform-tools" "platforms;android-36" "build-tools;36.1.0"
flutter config --android-sdk $ANDROID_HOME

# 4) التحقق
flutter doctor -v
```

### الخيار (ب): العمل على جهازك أنت

إذا أردت التشغيل على هاتفك أو بناء iOS، ثبّت الأدوات على جهازك من الروابط الرسمية:
- Flutter: https://docs.flutter.dev/get-started/install
- Android Studio وSDK: https://developer.android.com/studio
- Xcode (macOS فقط): https://developer.apple.com/xcode/ ثم CocoaPods: https://guides.cocoapods.org/using/getting-started.html
- ثم شغّل `flutter doctor -v` وأرسل لي الناتج.

**التوصية:** الخيار (أ) لبدء الكود والاختبارات وبناء APK هنا، مع الخيار (ب) لاحقًا على جهازك لاختبار الكاميرا الحقيقية وiOS.

### قرارات مطلوبة منك قبل المرحلة الثانية
1. الموافقة على تثبيت Flutter وAndroid SDK هنا (الخيار أ) وقبول رخص Android SDK.
2. مستودع GitHub لحفظ العمل: هل لديك مستودع جاهز، أم أنشئ مستودعًا خاصًا باسم مقترح مثل `baseer-app`؟
3. معرّف الحزمة (Bundle ID / Application ID)، مثل `com.yourname.baseer`. هذا القرار نهائي بعد النشر.
4. هل يتوفر لديك جهاز Mac وهاتف Android/iPhone للاختبار؟

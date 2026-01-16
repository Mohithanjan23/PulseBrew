# ☕ PulseBrew

**PulseBrew** is a smart, AI-assisted wellness application that monitors user health signals and provides intelligent caffeine reminders.  
The app is designed for **Android phones and future smartwatch integration**, helping users optimize energy, focus, and well-being.

---

## 🚀 Features

- 📊 **Health Data Integration**
  - Reads heart rate, activity, and wellness data using Android Health Connect
- ⏰ **Smart Caffeine Reminders**
  - Notifies users when caffeine may be needed based on physiological signals
- 📱 **Modern Flutter UI**
  - Clean, responsive interface built with Flutter
- 🔐 **Privacy-First**
  - All health data access is permission-based
- ⚙️ **Production-Ready**
  - Android App Bundle (AAB) compatible with Google Play Store

---

## 🛠 Tech Stack

### Frontend
- **Flutter**
- Dart

### Android Platform
- Android SDK 36
- Health Connect
- Kotlin
- Gradle (Kotlin DSL)

### Plugins
- `health`
- `device_info_plus`
- `shared_preferences`
- `path_provider`
- `sqflite`

---

## 📂 Project Structure

```
pulsebrew_app/
│
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── screens/
│   ├── services/
│   └── widgets/
│
├── assets/
├── pubspec.yaml
└── README.md
```

---

## ⚙️ Requirements

- Flutter SDK (stable)
- Java JDK **17**
- Android SDK **36**
- Android NDK (recommended)

---

## 🧪 Build & Run

```bash
flutter pub get
flutter run
flutter build appbundle
```

Output:
```
build/app/outputs/bundle/release/app-release.aab
```

---

## 🔐 Permissions

- Health Connect
- Notifications

---

## 🧠 Roadmap

- Wear OS support
- AI-based energy prediction
- Smart caffeine dosage
- Analytics dashboard
- iOS support

---

## 📄 License

MIT License

---

## 👤 Author

**Mohith Anjan**  
GitHub: https://github.com/Mohithanjan23

> _PulseBrew — Fuel smarter, not harder._

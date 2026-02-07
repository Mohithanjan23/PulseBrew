# ☕ PulseBrew (Antigravity Edition)

**PulseBrew** is a smart, offline-first, AI-driven coffee companion app that monitors user health signals and provides intelligent caffeine reminders.

**Architecture**: Flutter (Android) + FastAPI (Railway) + Supabase (Sync) + SQFlite (Offline).

---
Backend: https://pulsebrew-production.up.railway.app/

---

## 🚀 Features

- 📊 **Health Data Integration**
  - Reads heart rate via `health` package (with Mock fallback for emulators).
- 🧠 **Deterministic AI**
  - Uses `CaffeineDecayModel` (Exponential decay, 5h half-life) to predict plasma levels.
- 📶 **Offline-First**
  - Works 100% offline using `sqflite`.
  - Syncs to Supabase when online via `SyncRepository`.
- ⚡ **FastAPI Backend**
  - Validates logic and provides backup recommendations.

---

## 🛠 Tech Stack

- **Mobile**: Flutter 3.x, Provider, Sqflite, Supabase Flutter.
- **Backend**: FastAPI, Python 3.10+, Pydantic.
- **Database**: Supabase (PostgreSQL), SQLite (Local).
- **Infrastructure**: Railway (Free Tier).

---

## 📂 Project Structure

```
pulsebrew/
├── backend/            # FastAPI Backend
│   ├── main.py
│   ├── logic.py        # AI Logic
│   ├── models.py       # Pydantic Models
│   └── schema.sql      # Database Schema
├── pulsebrew_app/      # Flutter App
│   ├── lib/
│   │   ├── services/   # LocalDB, Sync, Biometrics
│   │   ├── logic/      # AI Logic (Dart)
│   │   └── ...
│   ├── android/
│   └── pubspec.yaml
└── README.md
```

---

## ⚙️ Setup & Run

### 1. Backend
```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

### 2. Mobile
```bash
cd pulsebrew_app
flutter pub get
flutter run
```

---

## 📄 License
MIT License

## 👤 Author
**Mohith Anjan**  
*Refactored by Antigravity*

# PulseBrew Deployment Guide

## 1. Backend (Railway + Supabase)

### Prerequisites
- Railway Account
- Supabase Project

### Steps
1.  **Supabase Setup**:
    - Go to Supabase > SQL Editor.
    - Run the contents of `backend/schema.sql`.
    - Get your `SUPABASE_URL` and `SUPABASE_KEY` (Anon).

2.  **Railway Setup**:
    - Create a new project on Railway.
    - Connect GitHub repo.
    - Set Root Directory to `/`.
    - Set Start Command: `uvicorn backend.main:app --host 0.0.0.0 --port $PORT`
    - **Variables**: Add the following environment variables in Railway:
        - `SUPABASE_URL`: value from above
        - `SUPABASE_KEY`: value from above

3.  **Deploy**:
    - Railway will auto-build.
    - Once active, your API URL will be `https://<your-project>.railway.app`.

## 2. Mobile App (Flutter)

### Prerequisites
- Flutter SDK
- Android Studio / Android SDK

### Configuration
1.  **Environment Variables**:
    - Build with passing dart-defines or create a `.env` file loaded by a config manager (if implemented).
    - Or hardcode API URL in `lib/services/api_service.dart` (if exists) or where you make HTTP calls.
    - **Note**: Ensure `SUPABASE_URL` and `SUPABASE_ANON_KEY` are configured in your Flutter initialization.

2.  **Build APK**:
    ```bash
    cd pulsebrew_app
    flutter clean
    flutter pub get
    flutter build apk --release
    ```
    - Output: `build/app/outputs/flutter-apk/app-release.apk`

3.  **Run Locally**:
    ```bash
    flutter run
    ```

## 3. Verification

- **Backend Health**: Visit `<your-railway-url>/health`.
- **App Sync**:
    - Open app offline -> Add caffeine -> Connect internet -> Check Supabase `intake_logs` table.

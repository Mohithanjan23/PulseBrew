plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.pulsebrew.app"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.pulsebrew.app"
        minSdk = 26
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }
}


flutter {
    source = "../.."
}

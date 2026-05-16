plugins {
    id("com.android.application")
    id("kotlin-android")

    // Flutter plugin
    id("dev.flutter.flutter-gradle-plugin")
}

android {

    namespace = "com.example.ad_campaign_performance_dashboard"

    compileSdk = 34

    ndkVersion = flutter.ndkVersion

    defaultConfig {

        applicationId = "com.example.ad_campaign_performance_dashboard"

        minSdk = flutter.minSdkVersion

        targetSdk = 34

        versionCode = flutter.versionCode

        versionName = flutter.versionName
    }

    compileOptions {

        sourceCompatibility = JavaVersion.VERSION_17

        targetCompatibility = JavaVersion.VERSION_17

        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {

        jvmTarget = "17"
    }

    buildTypes {

        release {

            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {

    coreLibraryDesugaring(
        "com.android.tools:desugar_jdk_libs:2.1.2"
    )
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:spendly_app/core/config/app_config.dart';

bool isFirebaseReady = false;

/// Initializes Firebase only when [AppConfig.firebaseEnabled] is true and
/// platform config files are present. Skips silently otherwise so local
/// plugins (SharedPreferences, etc.) are not affected by a failed native init.
Future<void> initializeFirebase() async {
  if (!AppConfig.firebaseEnabled) {
    if (kDebugMode) {
      debugPrint('Firebase disabled — using offline mode. Run flutterfire configure to enable.');
    }
    return;
  }

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    isFirebaseReady = true;
  } catch (e, st) {
    isFirebaseReady = false;
    if (kDebugMode) {
      debugPrint('Firebase init skipped: $e\n$st');
    }
  }
}

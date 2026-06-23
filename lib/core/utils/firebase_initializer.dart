import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Initialize Firebase when platform options are configured.
/// Run `flutterfire configure` to generate firebase_options.dart.
Future<void> initializeFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Firebase init skipped: $e');
    }
  }
}

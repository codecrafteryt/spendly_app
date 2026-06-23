import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Optional network helper. Call [initialize] only when needed — never at app
/// startup, so a missing native plugin cannot block launch.
class CheckConnectionService {
  bool hasConnection = false;

  final StreamController<bool> connectionChangeController =
      StreamController<bool>.broadcast();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _initialized = false;

  void initialize() {
    if (_initialized) return;
    _initialized = true;

    try {
      _subscription =
          _connectivity.onConnectivityChanged.listen(_connectionChange);
    } on MissingPluginException catch (e) {
      if (kDebugMode) {
        debugPrint('Connectivity plugin unavailable: $e');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Connectivity init skipped: $e');
      }
    }

    unawaited(checkConnection());
  }

  Stream<bool> get connectionChange => connectionChangeController.stream;

  void dispose() {
    _subscription?.cancel();
    connectionChangeController.close();
  }

  void _connectionChange(List<ConnectivityResult> results) {
    unawaited(checkConnection());
  }

  Future<bool> checkConnection() async {
    final previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      hasConnection =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}

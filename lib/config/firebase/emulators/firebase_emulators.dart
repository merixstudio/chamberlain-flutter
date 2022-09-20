import 'dart:developer';

import 'package:chamberlain/config/env_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseEmulators {
  FirebaseEmulators._();

  static String defaultFirebaseEmulatorHost = 'localhost';

  static Future<void> initializeEmulators() async {
    log('### Firebase emulators ${EnvVariables.emulatorEnabled ? 'enabled' : 'disabled'}');
    if (EnvVariables.emulatorEnabled) {
      log('### Host: $_platformHost');
      _initFirebaseFirestore(_platformHost);
    }
  }

  static String get _platformHost {
    final String customHost = EnvVariables.emulatorHost;
    return customHost.isNotEmpty ? customHost : defaultFirebaseEmulatorHost;
  }

  static void _initFirebaseFirestore(
    String host, {
    int port = 8080,
  }) {
    //It's a workaround for web that's occur error on hot reload
    //https://github.com/firebase/flutterfire/issues/6216
    try {
      FirebaseFirestore.instance.useFirestoreEmulator(
        host,
        port,
        sslEnabled: false,
      );
    } catch (error) {
      // throws a JavaScript object instead of a FirebaseException
      final String code = (error as dynamic).code;
      if (code != 'failed-precondition') {
        rethrow;
      }
    }
  }
}

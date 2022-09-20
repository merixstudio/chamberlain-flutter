import 'package:chamberlain/config/env_variables.dart';
import 'package:chamberlain/config/firebase/dev/firebase_options.dart' as dev;
import 'package:chamberlain/config/firebase/prod/firebase_options.dart' as prod;
import 'package:chamberlain/config/flavor_type.dart';
import 'package:firebase_core/firebase_core.dart';

class FlavorFirebaseOptions {
  FlavorFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    final FlavorType flavorType = FlavorType.fromValue(EnvVariables.flavor);
    switch (flavorType) {
      case FlavorType.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      default:
        return prod.DefaultFirebaseOptions.currentPlatform;
    }
  }
}

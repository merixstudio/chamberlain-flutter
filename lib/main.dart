import 'package:chamberlain/config/firebase/emulators/firebase_emulators.dart';
import 'package:chamberlain/config/firebase/flavor_firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chamberlain/config/injector/di.dart';
import 'package:chamberlain/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI.instance.setupInjection();
  await Firebase.initializeApp(
    options: FlavorFirebaseOptions.currentPlatform,
  );
  await FirebaseEmulators.initializeEmulators();
  runApp(const App());
}

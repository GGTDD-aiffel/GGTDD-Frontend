import 'package:firebase_core/firebase_core.dart';
import 'package:ggtdd_frontend/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/flavor_config.dart';
import 'config/providers.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlavorConfig(
    flavor: Flavor.development,
    baseUrl: "http://0.0.0.0:8000",
  );
  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MyApp(),
    ),
  );
}

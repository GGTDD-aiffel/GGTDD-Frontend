import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/flavor_config.dart';
import 'config/providers.dart';
import 'app.dart';

void main() {
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

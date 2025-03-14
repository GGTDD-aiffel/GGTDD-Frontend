import 'package:flutter/material.dart';
import 'package:ggtdd_frontend/config/providers.dart';
import 'package:provider/provider.dart';
import 'config/flavor_config.dart';
import 'app.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.staging,
    baseUrl: "https://staging.api.example.com",
  );
  runApp(
    MultiProvider(
      providers: getProviders(),
      child: MyApp(),
    ),
  );
}

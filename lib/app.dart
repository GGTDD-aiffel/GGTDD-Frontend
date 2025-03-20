import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/config/providers.dart';
import 'package:ggtdd_frontend/routing/app_routes.dart';
import 'package:ggtdd_frontend/ui/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return MultiProvider(
      providers: getProviders(),
      child: GetMaterialApp(
        title: 'My App',
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.pages,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}

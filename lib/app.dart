import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routing/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Flutter App',
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}

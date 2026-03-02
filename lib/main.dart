import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/theme_manager.dart';
import 'core/utils/router/app_router.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp(), enabled: true));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App Project",
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.themeData,
      initialRoute: PagesRoutesName.onBoardingView,
      onGenerateRoute: AppRouter.onGenerate,
    );
  }
}

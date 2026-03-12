import 'package:flutter/material.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/theme_manager.dart';
import 'Features/home/presentation/screens/layout_view.dart';
import 'core/services/service_locator.dart';
import 'core/utils/router/app_router.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: "Movies App Project",
    debugShowCheckedModeBanner: false,
    theme: ThemeManager.themeData,
    initialRoute: PagesRoutesName.layoutView,
    onGenerateRoute: AppRouter.onGenerate,

  );
  }
}
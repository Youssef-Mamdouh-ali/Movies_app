import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/theme_manager.dart';
import 'Features/authentication/login/Login_cubit/auth_cubit.dart';
import 'Features/authentication/services/auth_services.dart';
import 'Features/home/layout_view/layout_view.dart';
import 'core/utils/router/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(builder: (context) =>
      BlocProvider(
        create: (context) =>AuthCubit(FirebaseAuthService()),
        child: MyApp(),
      ), enabled: true));
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

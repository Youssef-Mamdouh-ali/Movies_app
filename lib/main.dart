import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app_project/core/services/loading_service.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/theme_manager.dart';

import 'Features/home/presentation/bloc/home_bloc.dart';
import 'Features/home/presentation/bloc/home_event.dart';
import 'core/services/service_locator.dart';
import 'core/utils/router/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  initDependencies();
  runApp(MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeStarted()),
      child: MaterialApp(
        title: "Movies App Project",
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.themeData,
        initialRoute: PagesRoutesName.homeView,
        onGenerateRoute: AppRouter.onGenerate,
        builder: EasyLoading.init(builder: BotToastInit()),
      ),
    );
  }
}

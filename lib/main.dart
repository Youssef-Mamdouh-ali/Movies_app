import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_bloc.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_event.dart';
import 'package:movies_app_project/Features/language/presentation/manager/language_state.dart';
import 'package:movies_app_project/core/services/loading_service.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';
import 'package:movies_app_project/core/utils/theme/theme_manager.dart';
import 'Features/home/presentation/bloc/home_bloc.dart';
import 'Features/home/presentation/bloc/home_event.dart';
import 'core/l10n/app_localizations.dart';
import 'core/services/service_locator.dart';
import 'core/utils/router/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupServiceLocator();
  await initDependencies();
  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeBloc>()..add(const HomeStarted())),
        BlocProvider(
          create: (_) => sl<LanguageBloc>()..add(LoadSavedLanguageEvent()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: "Movies App Project",
            debugShowCheckedModeBanner: false,
            theme: ThemeManager.themeData,
            locale: state.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            initialRoute: PagesRoutesName.layoutView,
            onGenerateRoute: AppRouter.onGenerate,
            builder: EasyLoading.init(builder: BotToastInit()),
          );
        },
      ),
    );
  }
}

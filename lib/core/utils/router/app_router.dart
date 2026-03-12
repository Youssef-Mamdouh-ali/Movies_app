import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/authentication/forget_password/forget_password.dart';
import 'package:movies_app_project/Features/authentication/login/log_in_view.dart';
import 'package:movies_app_project/Features/authentication/register/register_view/register_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/browse_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/home_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/layout_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/profile_view.dart';
import 'package:movies_app_project/Features/home/presentation/screens/search_view.dart';
import 'package:movies_app_project/Features/onBoarding/view/on_boarding_screen.dart';
import 'package:movies_app_project/Features/update_profile/update_profile_screen.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';

import '../../../Features/authentication/presentation/manager/auth_bloc.dart';
import '../../../Features/authentication/presentation/pages/forget_password.dart';
import '../../../Features/authentication/presentation/pages/log_in_view.dart';
import '../../../Features/authentication/presentation/pages/register_view.dart';
import '../../services/service_locator.dart';

abstract class AppRouter {
  static Route<dynamic>?  onGenerate(RouteSettings settings) {

    switch (settings.name) {

    case PagesRoutesName.loginView:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const LogInView(),
        ),
      );
      case PagesRoutesName.registerView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<AuthBloc>(),
            child: const RegisterView(),
          ),
        );
      case PagesRoutesName.forgetPasswordView:
        return MaterialPageRoute(
          builder: (context) => ForgetPassword(),
        );
        case PagesRoutesName.onBoardingView:
        return MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        );

      case PagesRoutesName.updateProfileScreen:
        return MaterialPageRoute(
          builder: (context) => UpdateProfileScreen(),
        );
      case PagesRoutesName.browseView:
        return MaterialPageRoute(
          builder: (context) => BrowseView(),
        );
      case PagesRoutesName.homeView:
        return MaterialPageRoute(
          builder: (context) => HomeView(),
        );
      case PagesRoutesName.layoutView:
        return MaterialPageRoute(
          builder: (context) => LayoutView(),
        );
      case PagesRoutesName.profileView:
        return MaterialPageRoute(
          builder: (context) => ProfileView(),
        );
      case PagesRoutesName.searchView:
        return MaterialPageRoute(
          builder: (context) => SearchView(),
        );

    default:
    return MaterialPageRoute(
    builder: (context) => RegisterView(),
    );

    }

    }

}
import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/authentication/forget_password/forget_password.dart';
import 'package:movies_app_project/Features/authentication/login/log_in_view.dart';
import 'package:movies_app_project/Features/authentication/register/register_view.dart';
import 'package:movies_app_project/Features/onBoarding/view/on_boarding_screen.dart';
import 'package:movies_app_project/core/utils/router/pages_routes_name.dart';

abstract class AppRouter {
  static Route<dynamic>?  onGenerate(RouteSettings settings) {

    switch (settings.name) {

    case PagesRoutesName.loginView:
    return MaterialPageRoute(
    builder: (context) => LogInView(),
    );
      case PagesRoutesName.registerView:
        return MaterialPageRoute(
          builder: (context) => RegisterView(),
        );
      case PagesRoutesName.forgetPasswordView:
        return MaterialPageRoute(
          builder: (context) => ForgetPassword(),
        );
        case PagesRoutesName.onBoardingView:
        return MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        );

    default:
    return MaterialPageRoute(
    builder: (context) => LogInView(),
    );

    }

    }

}
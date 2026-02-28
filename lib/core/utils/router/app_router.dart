import 'package:flutter/material.dart';
import 'package:movies_app_project/Features/authentication/forget_password/forget_password.dart';
import 'package:movies_app_project/Features/authentication/login/log_in_view.dart';
import 'package:movies_app_project/Features/authentication/register/register_view/register_view.dart';
import 'package:movies_app_project/Features/home/browse_view/browse_view.dart';
import 'package:movies_app_project/Features/home/home_view/home_view.dart';
import 'package:movies_app_project/Features/home/layout_view/layout_view.dart';
import 'package:movies_app_project/Features/home/profile_view/profile_view.dart';
import 'package:movies_app_project/Features/home/search_view/search_view.dart';
import 'package:movies_app_project/Features/onBoarding/view/on_boarding_screen.dart';
import 'package:movies_app_project/Features/update_profile/update_profile_screen.dart';
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
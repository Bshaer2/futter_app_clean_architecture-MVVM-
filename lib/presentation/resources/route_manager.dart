import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view.dart';
import 'package:tut_app/presentation/login/login_view.dart';
import 'package:tut_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:tut_app/presentation/register/register_view.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/store_details_view.dart';

import '../main/main_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String forgerPasswordRoute = "/forgerPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String registerRoute = "/register";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    Route<dynamic> route = _buildMaterialPageRoute(MainView()) ;
    switch (settings.name) {
      case Routes.splashRoute: route = _buildMaterialPageRoute(SplashView());
      case Routes.mainRoute: route = _buildMaterialPageRoute(MainView());
      case Routes.onBoardingRoute: route = _buildMaterialPageRoute(OnboardingView());
      case Routes.loginRoute: route = _buildMaterialPageRoute(LoginView());
      case Routes.registerRoute: route = _buildMaterialPageRoute(RegisterView());
      case Routes.forgerPasswordRoute: route = _buildMaterialPageRoute(ForgetPasswordView());
      case Routes.storeDetailsRoute: route = _buildMaterialPageRoute(StoreDetailsView());
      default: () => undefinedPageRoute();
    }
    return route;
  }

  static MaterialPageRoute<dynamic> _buildMaterialPageRoute(dynamic view) =>
      MaterialPageRoute(builder: (_) => view);

  static Route<dynamic> undefinedPageRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(StringsManager.undefinedRouterMessage),
              ),
              body: const Text(StringsManager.undefinedRouterMessage),
            ));
  }
}

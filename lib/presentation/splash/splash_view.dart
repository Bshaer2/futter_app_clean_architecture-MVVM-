import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/dependency_injection.dart';
import '../resources/constants_manager.dart';
import '../resources/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer( Duration(seconds: Constants.splashViewTimer), _goNext);
  }

  void _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
      if (isUserLoggedIn)
        {
          // navigate to main screen

          Navigator.pushReplacementNamed(context, Routes.mainRoute)
        }
      else
        {
          _appPreferences
              .isOnBoardingScreenViewed()
              .then((isOnBoardingScreenViewed) => {
            if (isOnBoardingScreenViewed)
              {
                // navigate to login screen

                Navigator.pushReplacementNamed(
                    context, Routes.loginRoute)
              }
            else
              {
                // navigate to onboarding screen

                Navigator.pushReplacementNamed(
                    context, Routes.onBoardingRoute)
              }
          })
        }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Center(
        child: Image(image: AssetImage(ImageManager.splashImage)),
      ),
    );
  }
}

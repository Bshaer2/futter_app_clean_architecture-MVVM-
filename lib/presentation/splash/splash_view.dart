import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/colors_manager.dart';

import '../resources/constants_manager.dart';
import '../resources/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startSplashViewTimer(){
    Timer(Duration(seconds: Constants.splashViewTimer), _goNextView);
  }

  _goNextView(){
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }
  @override
  void initState() {
    super.initState();
    _startSplashViewTimer();
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

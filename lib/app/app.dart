import 'package:flutter/material.dart';

import '../presentation/resources/route_manager.dart';
import '../presentation/resources/theme_manager.dart';

class TutApp extends StatelessWidget {

  const TutApp._internal();//named constructor

  static final TutApp _instance = TutApp._internal();//singleton

  factory TutApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute ,
      initialRoute:Routes.splashRoute,
      theme: getAppThemeDate(),
    );
  }
}

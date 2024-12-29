import 'package:flutter/material.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {

  const MyApp._internal();//named constructor

  static final MyApp _instance = MyApp._internal();//singleton

  factory MyApp() => _instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppThemeDate(),
    );
  }
}

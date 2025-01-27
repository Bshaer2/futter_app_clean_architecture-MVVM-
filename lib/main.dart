import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget  {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return TutApp();
  }
}
import 'package:flutter/material.dart';
import 'package:interview_app/Colors/colors.dart';
import 'package:interview_app/Modules/Module_1_Home/UI/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}

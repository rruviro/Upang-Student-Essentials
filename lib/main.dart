// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:use/UI/Authentication/login.dart';
import 'package:use/UI/Core/bag.dart';
import 'package:use/UI/Core/course.dart';
import 'package:use/UI/Core/welcome.dart';
import 'package:use/UI/Core/navigation.dart';
import 'package:use/UI/splash-screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
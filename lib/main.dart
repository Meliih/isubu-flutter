import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isubu_universite/Calculator.dart';
import 'package:isubu_universite/LoginPage.dart';
import 'package:isubu_universite/Register.dart';
import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => AppState();
}

class AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: Calculator(),
    );
  }
}
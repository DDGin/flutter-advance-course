import 'package:flutter/material.dart';
import 'package:flutter_advance_course/presentation/resources/route_manager.dart';
import 'package:flutter_advance_course/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  int appState = 0;

  MyApp._internal(); // private name constructor

  static final MyApp instance =
      MyApp._internal(); // single instance -- singleton
// https://stackoverflow.com/questions/70009725/making-an-instance-of-a-class-in-dart

  factory MyApp() => instance; // factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
//State<MyApp> createState() => _MyAppState();
//https://stackoverflow.com/questions/69609489/flutter-statewidgetname-createstate-widgetnamestate
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}

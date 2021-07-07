import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numbers/pages/home.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        statusBarIconBrightness: Brightness.dark)); //dark status bar icons
    return MaterialApp(
      home: Home(),
    );
  }
}

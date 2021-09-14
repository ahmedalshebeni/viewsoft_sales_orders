import 'package:flutter/material.dart';
import 'package:viewsoft_hr/refrence/shared.dart';
import 'login.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isLoggedIn = false;

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("loggedin")
        .then((value) => setState(() {
      isLoggedIn = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: isLoggedIn ? Profile() : Login());
  }
}
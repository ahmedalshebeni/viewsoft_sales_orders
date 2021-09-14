
import 'package:flutter/material.dart';
import 'package:viewsoft_hr/masterDetal/master_detail_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master-Detail example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MasterDetailContainer(),
    );
  }
}
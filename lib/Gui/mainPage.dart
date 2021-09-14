




import 'package:flutter/material.dart';

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main"),
      ),
      body: Container(
        child: Text("main"),
        color:Colors.grey ,
      ),
    );
  }
}

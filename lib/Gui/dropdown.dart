import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dropdownvalue = 'Apple';

  var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDownList Example"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: dropdownvalue,

                icon: Icon(Icons.keyboard_arrow_down),

                items:items.map((String items) {
                  return DropdownMenuItem(
                      value: items,
                      child: Text(items)
                  );
                }
                ).toList(),

                onChanged: (String newValue){
                  setState(() {
                    dropdownvalue = newValue;
                  });
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
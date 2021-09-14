import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Test project'),
      ),

      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new TestStatefulWidget(),
      ),
    ),
  ));
}

class TestStatefulWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new TestStatefulWidgetState();
}

class TestStatefulWidgetState extends State<TestStatefulWidget> {

  static const List<String> shortItems = const [
    'These',
    'items',
    'are',
    'short',
    'enough',
  ];

  static const List<String> longItems = const [
    'These items will probably be longer than what fits on the screen correctly',
    'Because of this, the icon indicator on the right side will not show',
    'Instead, in development mode, a red indicator will display, showing something is wrong',
  ];

  String shortSpinnerValue = shortItems[0];
  String longSpinnerValue = longItems[0];

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new DropdownButton(
          value: shortSpinnerValue,
          onChanged: (string) => setState(() => shortSpinnerValue = string),
          items: shortItems.map((string) {
            return new DropdownMenuItem(
              child: new Text(string),
              value: string,
            );
          }).toList(),
        ),

        new DropdownButton(
          value: longSpinnerValue,isExpanded: true,
          onChanged: (string) => setState(() => longSpinnerValue = string),
          items: longItems.map((string) {
            return new DropdownMenuItem(
              child: new Text(string),
              value: string,

            );
          }).toList(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter',
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() {
    return _FirstScreenState();
  }
}

class _FirstScreenState extends State<FirstScreen> {

  String text = 'Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 24),
              ),
            ),

            RaisedButton(
              child: Text(
                'Go to second screen',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                _awaitReturnValueFromSecondScreen(context);
              },
            )

          ],
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      text = result;
    });
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() {
    return _SecondScreenState();
  }
}

class _SecondScreenState extends State<SecondScreen> {
  // this allows us to access the TextField text
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: textFieldController,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),

          RaisedButton(
            child: Text(
              'Send text back',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              _sendDataBack(context);
            },
          )

        ],
      ),
    );
  }

  // get the text in the TextField and send it back to the FirstScreen
  void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    Navigator.pop(context, textToSendBack);
  }
}
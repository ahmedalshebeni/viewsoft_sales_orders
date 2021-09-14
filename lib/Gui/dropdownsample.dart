import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// To parse this JSON data, do
//
//     final payload = payloadFromJson(jsonString);

import 'dart:convert';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  List<Datum> data;

  Payload({
    this.data,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  DateTime date;
  List<Detail> details;

  Datum({
    this.date,
    this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: DateTime.parse(json["Date"]),
    details:
    List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  int id;

  Detail({
    this.id,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Payload payload;
  Datum dropdownValue = null;
  Future getData() async {
    var response = await http
         // .get('http://192.168.1.50/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select stk_id,stk_name from stk_stocks order by 2');
        .get("https://www.json-generator.com/api/json/get/bOpGzigKOG?indent=2");
    payload = payloadFromJson(response.body);
    setState(() {});
    return 'success';
  }
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: payload == null
          ? CircularProgressIndicator()
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: DropdownButton<Datum>(
                //isDense: true,
                hint: Text('Choose'),
                value: dropdownValue,
                isExpanded: true,
                icon: Icon(Icons.check_circle_outline),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.blue[300],
                ),
                onChanged: (Datum newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: payload.data
                    .map<DropdownMenuItem<Datum>>((Datum value) {
                  return DropdownMenuItem<Datum>(
                      value: value,
                      child: Text(
                          ' ${value.date.year.toString()}/${value.date.month.toString()}/${value.date.day.toString()}'));
                }).toList(),
              ),
            ),
            ListView.builder(
                itemCount: payload == null ? 0 : payload.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: payload == null? 0: payload.data[index].details.length,
                      itemBuilder: (context, i) {
                        if (dropdownValue == null) {
                          return ListTile(
                              title: Text(
                                  "${payload.data[index].details[i].id}"));
                        } else {
                          if (payload.data[index] == dropdownValue) {
                            return ListTile(
                                title: Text(
                                    "${payload.data[index].details[i].id}"));
                          } else {
                            return Container();
                          }
                        }
                      });
                }),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}


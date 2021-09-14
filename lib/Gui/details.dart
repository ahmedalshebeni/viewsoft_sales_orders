import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  // DateTime date;
  // List<Detail> details;


  String stk_id;
  String stk_name;
  String sal_tr_type_id;
  String sal_tr_type_name;
  String curr_code;
  String curr_name;
  String item_id;
  String item_name;
  String u_id;
  String u_name;
  Datum({
    this.stk_id,
    this.stk_name,
    this.sal_tr_type_id,
    this.sal_tr_type_name,
    this.curr_code,
    this.curr_name,
    this.item_id,
    this.item_name,
    this.u_id,
    this.u_name,
    // this.date,
    // this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(

      stk_name:json["stk_name"],
      stk_id:json["stk_id"],
      sal_tr_type_id:json["sal_tr_type_id"],
      sal_tr_type_name: json["sal_tr_type_name"],
      curr_code: json ["curr_code"],
      curr_name: json ["curr_name"],
      item_id :json ["item_id"],
      item_name :json ["item_name"],
    u_id :json ["u_id"],
    u_name :json ["u_name"],

    // date: DateTime.parse(json["Date"]),
    // details:
    // List<Detail>.from(json["Details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stk_id":"${stk_id}",
    "stk_name":"${stk_name}",
    "sal_tr_type_id":"${sal_tr_type_id}",
    "sal_tr_type_name":"${sal_tr_type_name}",
    "curr_code":"${curr_code}",
    "curr_name" : "${curr_name}",
    "item_id": "${item_id}",
    "item_name": "${item_name}",
    "u_id" :"${u_id}",
    "u_name":"${u_name}",
    //   "Date":
    //  "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    //   "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class detail extends StatefulWidget {
  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  bool isInit =true;
  String ipaaddress;
  // String stk;
  Payload payload;
  Payload payload2;
  Payload payload3;
  Datum dropdownValue = null;
  Datum dropdownValue2 = null;
  Datum dropdownValue3 = null;

  Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ipaaddress= prefs.getString("address");
    // stk = prefs.getString("stk_id");
    try{
      var response = await http
      // .get('http://192.168.1.50/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select stk_id,stk_name from stk_stocks order by 2');
      // .get("https://www.json-generator.com/api/json/get/bOpGzigKOG?indent=2");
          .get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20item_id,item_name%20from%20stk_items");
      var res= await http.
      get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20u_id%20,u_name%20from%20stk_unit_of_measurs");
      // .get("http://192.168.1.50/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20emp_id%20,emp_name%20from%20hr_emp%20where%20v_flex10%20is%20not%20null");
      // .get("https://jsonplaceholder.typicode.com/posts");
      // print(res.body);
      // print(response.body);
      var resp = await http.
      get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20curr_code,curr_name%20from%20currencies%20order%20by%201");
      payload = payloadFromJson(response.body);
      payload2 = payloadFromJson(res.body);
      payload3=payloadFromJson(resp.body);
      return 'success';
    }catch(err){
      print(err);
      throw err;

    }

  }
  @override
  void didChangeDependencies() {
    if(isInit){
      getData().then((value) {
        print(value);
        setState(() {
          isInit = false;
        });
      });
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,
      title: Text("Detail"),),
      body: isInit ?Center(child: CircularProgressIndicator())  :
      Center(
        child: Container(
          child: ListView(
            children: [
              new Container(
                padding: EdgeInsets.all(5.50),
                margin: EdgeInsets.only(right:2.0),
                child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Image.asset(
                        'img/viewsoft.png',
                        // img/1.jpg  img/userbackground.png img/viewsoft.png
                        height: 65.0,
                        width: 50.0,
                      ),
                      Column(
                        children: [
                          DropdownButton<Datum>(
                            //isDense: true,
                            hint: Text('الصنف'),
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
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                print(dropdownValue.item_id);
                              });
                            },
                            items: payload.data
                                .map<DropdownMenuItem<Datum>>((value) {
                              return DropdownMenuItem<Datum>(
                                  value:  value,
                                  child:Text(' ${value.item_name}'));
                            }).toList(),
                          ),
                          DropdownButton<Datum>(
                            //isDense: true,
                            hint: Text('الوحدة'),
                            value: dropdownValue2,
                            isExpanded: true,
                            icon: Icon(Icons.check_circle_outline),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.blue[300],
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue2 = newValue;
                                print(dropdownValue2.u_id);
                              });
                            },
                            items: payload2.data
                                .map<DropdownMenuItem<Datum>>((value) {
                              return DropdownMenuItem<Datum>(
                                  value:  value,
                                  child:Text(' ${value.u_name}'));
                            }).toList(),
                          ),
                          // DropdownButton<Datum>(
                          //   //isDense: true,
                          //   hint: Text('شرط الدفع'),
                          //   value: dropdownValue,
                          //   isExpanded: true,
                          //   icon: Icon(Icons.check_circle_outline),
                          //   iconSize: 24,
                          //   elevation: 16,
                          //   style: TextStyle(color: Colors.deepPurple),
                          //   underline: Container(
                          //     height: 2,
                          //     color: Colors.blue[300],
                          //   ),
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       dropdownValue = newValue;
                          //       print(dropdownValue.stk_id);
                          //     });
                          //   },
                          //   items: payload.data
                          //       .map<DropdownMenuItem<Datum>>((value) {
                          //     return DropdownMenuItem<Datum>(
                          //         value:  value,
                          //         child:Text(' ${value.stk_name}'));
                          //   }).toList(),
                          // ),
                          // DropdownButton<Datum>(
                          //   //isDense: true,
                          //   hint: Text('العميل'),
                          //   value: dropdownValue,
                          //   isExpanded: true,
                          //   icon: Icon(Icons.check_circle_outline),
                          //   iconSize: 24,
                          //   elevation: 16,
                          //   style: TextStyle(color: Colors.deepPurple),
                          //   underline: Container(
                          //     height: 2,
                          //     color: Colors.blue[300],
                          //   ),
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       dropdownValue = newValue;
                          //       print(dropdownValue.stk_id);
                          //     });
                          //   },
                          //   items: payload.data
                          //       .map<DropdownMenuItem<Datum>>((value) {
                          //     return DropdownMenuItem<Datum>(
                          //         value:  value,
                          //         child:Text(' ${value.stk_name}'));
                          //   }).toList(),
                          // ),
                          // DropdownButton<Datum>(
                          //   //isDense: true,
                          //   hint: Text('شرط الدفع'),
                          //   value: dropdownValue,
                          //   isExpanded: true,
                          //   icon: Icon(Icons.check_circle_outline),
                          //   iconSize: 24,
                          //   elevation: 16,
                          //   style: TextStyle(color: Colors.deepPurple),
                          //   underline: Container(
                          //     height: 2,
                          //     color: Colors.blue[300],
                          //   ),
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       dropdownValue = newValue;
                          //       print(dropdownValue.stk_id);
                          //     });
                          //   },
                          //   items: payload.data
                          //       .map<DropdownMenuItem<Datum>>((value) {
                          //     return DropdownMenuItem<Datum>(
                          //         value:  value,
                          //         child:Text(' ${value.stk_name}'));
                          //   }).toList(),
                          // ),
                          new TextField(
                            style: TextStyle(fontSize: 15.0, color: Colors.deepPurple),
                            // controller: _userController,
                            decoration: InputDecoration(
                                icon: new Icon(
                                  Icons.person,
                                  color: Colors.deepPurple,
                                  size: 20.0,
                                ),
                                hintText: 'ت.الصلاحية'),
                            // keyboardType: TextInputType.number,
                          ),
                          new TextField(
                            style: TextStyle(fontSize: 15.0, color: Colors.deepPurple),
                            // controller: _userController,
                            decoration: InputDecoration(
                                icon: new Icon(
                                  Icons.person,
                                  color: Colors.deepPurple,
                                  size: 20.0,
                                ),
                                hintText: 'الكمية'),
                            // keyboardType: TextInputType.number,
                          ),
                          new TextField(
                            style: TextStyle(fontSize: 15.0, color: Colors.deepPurple),
                            // controller: _userController,
                            decoration: InputDecoration(
                                icon: new Icon(
                                  Icons.person,
                                  color: Colors.deepPurple,
                                  size: 20.0,
                                ),
                                hintText: 'السعر'),
                            // keyboardType: TextInputType.number,
                          ),


                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          child: new TextButton(
              onPressed:() => {},
              child: Text("Save"))
      ),
    );

  }
}

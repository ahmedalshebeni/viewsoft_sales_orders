import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  Datum({

    this.stk_id,
    this.stk_name,
    this.sal_tr_type_id,
    this.sal_tr_type_name,
    this.curr_code,
    this.curr_name,
    // this.date,
    // this.details,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(

      stk_name:json["stk_name"],
      stk_id:json["stk_id"],
      sal_tr_type_id:json["sal_tr_type_id"],
      sal_tr_type_name: json["sal_tr_type_name"],
      curr_code: json ["curr_code"],
      curr_name: json ["curr_name"]
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
    //   "Date":
    //  "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    //   "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class BasicData extends StatefulWidget {
  @override
  _BasicDataState createState() => _BasicDataState();
}

class _BasicDataState extends State<BasicData> {
  // int _counter = 0;

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
      // .get("https://www.json-generator.com/api/json/get/bOpGzigKOG?indent=2");
          .get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20stk_id,stk_name%20from%20stk_stocks");
      var res= await http.
      get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20sal_tr_type_id,sal_tr_type_name%20from%20sal_trans_types%20order%20by%202");

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

 setstk()async{
   SharedPreferences sharedPreferences =    await SharedPreferences.getInstance();
   sharedPreferences.setString('stk_id', dropdownValue.stk_id);
   var name = sharedPreferences.getString('stk_id');
   print("::::"+name);
 }
  //org,comp,br from stk_id
  getparam()async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stk_id', dropdownValue.stk_id);
    var adress= prefs.getString("address");
    var stk_id = prefs.getString('stk_id');
    // Map tr_id = await gettr_id();
    // int id = tr_id["data"][0]["tr_id"];
    String url=
    'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20(select%20org_id%20from%20branches%20where%20comp_code=b.comp_code%20and%20branch_code=b.branch_code)%20org_id,comp_code,branch_code%20from%20branches%20b%20where%20comp_code=(select%20stk_cmp_code%20from%20stk_stocks%20where%20stk_id=$stk_id)%20and%20branch_code=(select%20stk_br_code%20from%20stk_stocks%20where%20stk_id=$stk_id)';
    http.Response response = await http.get(url);
    print(url);
    print(response.body);
    return json.decode(response.body);
  }
  getparam2()async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stk_id', dropdownValue.stk_id);
    var adress= prefs.getString("address");
    var stk_id = prefs.getString('stk_id');
    Map tr_id = await getparam();
    String org = tr_id["data"][0]["org_id"];
    String comp = tr_id["data"][0]["comp_code"];
    String branch = tr_id["data"][0]["branch_code"];
    String url=
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20(select%20org_id%20from%20branches%20where%20comp_code=b.comp_code%20and%20branch_code=b.branch_code)%20org_id,comp_code,branch_code%20from%20branches%20b%20where%20comp_code=(select%20stk_cmp_code%20from%20stk_stocks%20where%20stk_id=$stk_id)%20and%20branch_code=(select%20stk_br_code%20from%20stk_stocks%20where%20stk_id=$stk_id)';
    http.Response response = await http.get(url);
    print(url);
    print(response.body);
    print(org   +  comp    +branch);
    // Navigator.of(context).pushNamed('/Second');
    return json.decode(response.body);
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
     appBar:  new AppBar(
         backgroundColor: Colors.deepPurple,
         title: const Text('BasicData Page')),
     body:isInit ?Center(child: CircularProgressIndicator())  : Center(
       child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Column(
               children: [
                 Container(
                   child: DropdownButton<Datum>(
                     //isDense: true,
                     hint: Text('ChooseStock'),
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
                         print(dropdownValue.stk_id);
                       });
                     },
                     items: payload.data
                         .map<DropdownMenuItem<Datum>>((value) {
                       return DropdownMenuItem<Datum>(
                           value:  value,
                            child:Text(' ${value.stk_name}'));
                     }).toList(),
                   ),
                 ),
                 Container(
                   child: DropdownButton<Datum>(
                     hint: Text('ChooseSales'),
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
                     onChanged: (Datum newValue) {
                       setState(() {
                         dropdownValue2 = newValue;
                         print(dropdownValue2.sal_tr_type_id);
                       });
                     },
                     items: payload2.data
                         .map<DropdownMenuItem<Datum>>((Datum value) {
                       return DropdownMenuItem<Datum>(
                           value: value,
                           child:Text(' ${value.sal_tr_type_name}'));
                           // child: Text(' ${value.date.year.toString()}/${value.date.month.toString()}/${value.date.day.toString()}'));
                     }).toList(),
                   ),
                 ),
                 Container(
                   child: DropdownButton<Datum>(
                     //isDense: true,
                     hint: Text('ChooseCurrency'),
                     value: dropdownValue3,
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
                         dropdownValue3 = newValue;
                         print(dropdownValue3.curr_code);
                       });
                     },
                     items: payload3.data
                         .map<DropdownMenuItem<Datum>>((Datum value) {
                       return DropdownMenuItem<Datum>(
                           value: value,
                           child:Text(' ${value.curr_name}'));
                       // child: Text(' ${value.date.year.toString()}/${value.date.month.toString()}/${value.date.day.toString()}'));
                     }).toList(),
                   ),
                 ),
               ],
             ),
   ],
    ),
     ),
   bottomNavigationBar:
   Container(
       child: TextButton(
           onPressed: getparam2,
           child: Text("post")
       )) ,

   );
  }
}



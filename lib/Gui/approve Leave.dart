import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:viewsoft_hr/providers/test_provider.dart';

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
  String cust_id;
  String cust_name;
  String pt_id;
  String pt_name;

  String item_id;
  String item_name;
  String u_id;
  String u_name;
  // int   tr_id;

  Datum({
    this.stk_id,
    this.stk_name,
    this.sal_tr_type_id,
    this.sal_tr_type_name,
    this.curr_code,
    this.curr_name,
    this.cust_id,
    this.cust_name,
    this.pt_id,
    this.pt_name,
    this.item_id,
    this.item_name,
    this.u_id,
    this.u_name,
    // this.tr_id,
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
    cust_id: json ["cust_id"],
    cust_name: json ["cust_name"],
    pt_id: json ["pt_id"],
    pt_name: json ["pt_name"],
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
    "cust_id":"${cust_id}",
    "cust_name" : "${cust_name}",
    "pt_id":"${pt_id}",
    "pt_name" : "${pt_name}",
    "curr_code":"${curr_code}",
    "curr_name" : "${curr_name}",
    "item_id": "${item_id}",
    "item_name": "${item_name}",
    "u_id" :"${u_id}",
    "u_name":"${u_name}",
    // "tr_id":"${tr_id}",
    //   "Date":
    //  "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    //   "Details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}


TextEditingController txtprice = new TextEditingController();
TextEditingController txtdate = new TextEditingController();
TextEditingController txtnote = new TextEditingController();
TextEditingController txtqty = new TextEditingController();
TextEditingController txtqantitiy = new TextEditingController();

class approveLeave extends StatefulWidget {
  @override
  _approveLeaveState createState() => _approveLeaveState();
}
Datum dropdownitem = null;
Payload payload;
Payload payload2;
Payload payload3;
Payload payload4;
Payload payloaditem;
Payload payloaduid;
Payload payloadcrr;
Datum dropdownValue = null;
Datum dropdownValue2 = null;
Datum dropdownValue3 = null;
Datum dropdownValue4= null;
int line_no =1;

Datum dropdownitem2 = null;
Datum dropdownuid = null;
Datum dropdownuid2 = null;
class _approveLeaveState extends State<approveLeave> {
  bool isInit =true;
  String ipaaddress;
   Album items ;
  Future<String> getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    ipaaddress= prefs.getString("address");

    try {
      var response = await http
          .get(
          "http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20cust_id%20,cust_name%20from%20sal_cust_file");
      var res = await http.
      get(
          "http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20pt_id%20,pt_name%20from%20ap_payment_terms_h");
      var resp = await http.
      get(
          "http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20curr_code,curr_name%20from%20currencies%20order%20by%201");

      var wtr_id = await http.
      get(
          "http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20create_id(%27sal_ord_h%27,%27tr_id%27)%20tr_id%20from%20dual");

      var item = await http
       .get(
          "http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20item_id,item_name%20from%20stk_items");
       var uid= await http.
      get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20u_id%20,u_name%20from%20stk_unit_of_measurs");
        var curr = await http.
      get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20curr_code,curr_name%20from%20currencies%20order%20by%201");

      payload = payloadFromJson(response.body);
      payload2 = payloadFromJson(res.body);
      payload3=payloadFromJson(resp.body);
      payload4=payloadFromJson(wtr_id.body);
      payloaditem =payloadFromJson(item.body);
      payloaduid=payloadFromJson(uid.body);
      payloadcrr=payloadFromJson(curr.body);
      return 'success';
    }catch(err){
      print(err);
      throw err;

    }

  }

//show all widget
  @override
  void didChangeDependencies() {
    if(isInit){
      // Provider.of<TestProvider>(context).getItems();
      // Provider.of<TestProvider>(context).getItemsUnit();
      getData().then((value) {
        print(value);
        setState(() {
          isInit = false;
        });
      });
    }
    super.didChangeDependencies();
  }
  void onPressed() async {
    print("object");
  }
  popinfo() {
    final snackBar = SnackBar(
      content: Text('تم الحفظ'),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  getparam()async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var adress= prefs.getString("address");
    var stk_id = prefs.getString('stk_id');
    String url=
        'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20(select%20org_id%20from%20branches%20where%20comp_code=b.comp_code%20and%20branch_code=b.branch_code)%20org_id,comp_code,branch_code%20from%20branches%20b%20where%20comp_code=(select%20stk_cmp_code%20from%20stk_stocks%20where%20stk_id=$stk_id)%20and%20branch_code=(select%20stk_br_code%20from%20stk_stocks%20where%20stk_id=$stk_id)';
    http.Response response = await http.get(url);
    print(url);
    print(response.body);
    return json.decode(response.body);
  }

  insertchekin() async {

    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var name = prefs.getString('name');
    var adress= prefs.getString("address");
    // print("emp_id :" + name);
    print("ip:"+adress);
    // userInfo = name;
    //get ORG_ID,COMP_CODE,BRANCH_CODE,YEAR,INV_TYPE,SAL_TR_TYPE_ID,ORD_NO,ORD_NO1,DELIV_PERIOD,CUST_ID,CURR_CODE,TR_ID
     Map tr_id = await gettr_id();
     print(tr_id);
    // Map end_date = await getenddate();
    // Map check_start_date = await chkstartdate();
     String id = tr_id["data"][0]["tr_id"];
     print("tr id :::"+id);
    Map stk = await getparam();
    String org = stk["data"][0]["org_id"];
    String comp = stk["data"][0]["comp_code"];
    String branch = stk["data"][0]["branch_code"];    // String Enddate = end_date["data"][0]["end_time"];
    // String checkStartDate = check_start_date["data"][0]["cnt"];
    print("massage");
    print(stk);
    print ("org::"+org + "comp::"+comp +"branch:::"+branch);
    print(dropdownValue.cust_id);
    //check if start_time found
    // if (checkStartDate == '0') {
    //   popstart();
    // }
    final msg = json.encode(
        [
          {
        // "emp_id": name,
        "org_id":org,
        "comp_code":comp,
        "branch_code":branch,
        "year":2021,
        "inv_type":1,
        "sal_tr_type_id":1,
        "ord_no":3,
        "ord_no1":"3",
        "deliv_period":1,
        "cust_id":dropdownValue.cust_id,
        "curr_code":3,
        "created_user":"ahmed",
        "created_date":"26-AUG-2021",
        "tr_id":id
        // "pt_id":dropdownValue2.pt_id,

      }
      ]

    );
    var url = Uri.parse(
        'http://$adress/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=sal_ord_h'

    );
    http.Response response = await http
        .post(url, body: msg, headers: {"content-type": "application/json"});
    print("done" + response.body);
    popinfo();
    // print("result"+jsonDecode(response.body)['name']);
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create .');
    }

  }

  gettr_id() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var adress= prefs.getString("address");
    String date =
        "http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20create_id(%27sal_ord_h%27,%27tr_id%27)%20tr_id%20from%20dual";
    http.Response response = await http.get(date);
       return json.decode(response.body);
  }


  Future all() async {
    // firstFunction().then((value){
    //   secondFunction();
    // });
    insertchekin();
    // insertdetail();
  }

  getid()async{
    Map datamapid = await gettr_id();
    String checkid = datamapid["data"][0]["tr_id"];
    print(checkid);
  }

  String value;

  @override
  Widget build(BuildContext context) {
    // List<Widget> children = List.generate(length, (e) => myContainerList[e]);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: new Text('Master Page'),
      ),
      body:isInit ?Center(child: CircularProgressIndicator())  : Center(
        child:
        Container(
          child: ListView(
              shrinkWrap : true,
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
                        height: 60.0,
                        width: 110.0,
                      ),
                      Column(
                        children: [
                          const Text("Master",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                          DropdownButton<Datum>(
                            //isDense: true,
                            hint: Text('العميل'),
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
                                print(dropdownValue.cust_id);
                              });
                            },
                            items: payload.data
                                .map<DropdownMenuItem<Datum>>((value) {
                              return DropdownMenuItem<Datum>(
                                  value:  value,
                                  child:Text(' ${value.cust_name}'));
                            }).toList(),
                          ),
                          DropdownButton<Datum>(
                            //isDense: true,
                            hint: Text('شرط الدفع'),
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
                                print(dropdownValue2.pt_id);
                              });
                            },
                            items: payload2.data
                                .map<DropdownMenuItem<Datum>>((value) {
                              return DropdownMenuItem<Datum>(
                                  value:  value,
                                  child:Text(' ${value.pt_name}'));
                            }).toList(),
                          ),
                          new TextFormField(
                            style: TextStyle(fontSize: 15.0, color: Colors.deepPurple),
                             controller: txtnote,
                            decoration: InputDecoration(
                                hintText: 'ملاحظات'),
                          ),
                          new TextField(
                            style: TextStyle(fontSize: 15.0, color: Colors.deepPurple),
                             controller: txtqty,
                            decoration: InputDecoration(
                              // icon: new Icon(
                              //   Icons.person,
                              //   color: Colors.deepPurple,
                              //   size: 20.0,
                              // ),
                                hintText: 'كميه الامر'),
                            keyboardType: TextInputType.number,

                          ),
                          SizedBox(
                            height: 5,
                          ),
                          const Text("Detail",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                          TextButton(
                              onPressed: (){
                                    context.read<TestProvider>().createDetailsWidget();
                              setState(() {
                              });
                              },
                             child: Text("Add ")),
                          for(var i in context.watch<TestProvider>().choosedDetailsWidget)
                          i

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
      bottomNavigationBar:
        Row(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            RaisedButton(
                onPressed: () async {
                  var master = await all();
                  bool isValid = await context.read<TestProvider>().sendDetailsData();
                  if(isValid == true){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Success', style: TextStyle(color: Colors.black)))
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('false', style: TextStyle(color: Colors.black)))
                    );
                  }
                },
                child: Text("Save"),
              color: Colors.deepPurple,
              textColor: Colors.white,

            )
          ],
        ),
    );
  }
}

class Album {
  final int org_id;
  final int comp_code;
  final int branch_code;
  final int year;
  final int line_no;
  final int item_id;
  final int u_id;
  final int u_price;
  final int u_conv_price;
  final int ord_qty;
  final int ord_conv_qty;
  final int ord_cost;
  final int ord_conv_cost;
  final int inv_type;
  final int sal_tr_type_id;
  final int ord_no;
  final String ord_no1;
  final int deliv_period;
  final int cust_id;
  final int curr_code;
  final String created_user;
  final String created_date;
  final int tr_id;
  final int pt_id;
  // final DateTime work_date;
  // final int work_type;
  // final String start_time;
  // final String end_time;

  Album(
      {
        this.org_id,
        this.comp_code,
        this.branch_code,
        this.line_no,
        this.item_id,
        this.u_id,
        this.u_price,
        this.u_conv_price,
        this.ord_cost,
        this.ord_conv_cost,
        this.ord_conv_qty,
        this.ord_qty,
        this.year,
        this.inv_type,
        this.sal_tr_type_id,
        this.ord_no,
        this.ord_no1,
        this.deliv_period,
        this.cust_id,
        this.curr_code,
        this.created_user,
        this.created_date,
        this.tr_id,
        this.pt_id


      }



      );

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      org_id: json['org_id'],
      comp_code: json['comp_code'],
      branch_code: json['branch_code'],
      line_no: json['line_no'],
      item_id:json['item_id'],
      u_id:json["u_id"],
      u_price:json["u_price"],
      u_conv_price:json["u_conv_price"],
      ord_qty:json["ord_qty"],
      ord_conv_qty:json["ord_conv_qty"],
      ord_cost:json["ord_cost"],
      ord_conv_cost:json["ord_conv_cost"],
      year: json['year'],
      inv_type: json['inv_type'],
      sal_tr_type_id: json['sal_tr_type_id'],
      ord_no: json['ord_no'],
      ord_no1: json['ord_no1'],
      deliv_period: json['deliv_period'],
      cust_id: json['cust_id'],
      curr_code: json['curr_code'],
      created_user: json['created_user'],
      created_date: json['created_date'],
      tr_id: json['tr_id'],
      pt_id: json['pt_id'],

    );
  }
}


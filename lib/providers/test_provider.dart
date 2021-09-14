
  import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viewsoft_hr/Gui/edited/model.dart';
import 'package:viewsoft_hr/Gui/rowWidget.dart';

class TestProvider with ChangeNotifier{
  String _ipaaddress;
  String _username;
  String get ipaaddress{
    return _ipaaddress;
  }
  String get username{
    return _username;
  }
  Future<void> getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('name', _userController.text);
    // prefs.setString('address',ipaddress.text);
    if(!prefs.containsKey('address')){
return;
    }
    _ipaaddress= prefs.getString("address");
    notifyListeners();
    print ("addres :" + _ipaaddress);
     if(!prefs.containsKey('name')){
return;
    }
    _username = prefs.getString('name');
    print("user :" +_username);
    notifyListeners();
  }

 Future<void> setpref(String address,
  String name,
  )async {
   _ipaaddress=address;
   _username=name;
   notifyListeners();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('address', address);
   sharedPreferences.setString('name', name);

}
Future<void> setUserName(String name)async {
   _username=name;
   notifyListeners();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('name', name);

}

Future<void>logout()async{
  _ipaaddress = null;
  _username = null;
  notifyListeners();
  final pref = await SharedPreferences.getInstance();
  pref.clear();
}


getdata(String  adress, String name) async {
      String url =
     'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select count(*) from sal_repres where  repres_id=$name and nvl(v_flex10,123)=123';
      http.Response response = await http.get(url);
      return json.decode(response.body);
    }


getsysdate(String adress) async {
      
      String date =
           'http://$adress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20sysdate%20from%20dual';
      http.Response response = await http.get(date);
      return json.decode(response.body);
    }

Future<String> onLogin(String name, String address) async {
      Map datamap = await getdata(address, name);
      Map datemap = await getsysdate(address);
      String check = datamap["data"][0]["count(*)"];
      String chkdate = datemap["data"][0]["sysdate"];
      print(check);
      print(chkdate);
        if (check != '0' ) {
           await setpref(address, name);
          // Navigator.of(context).pushNamed('/First');
          // Navigator.pushReplacementNamed(context, '/Second');
        }
        else {
          return 'you Name or Ip is Invalid:';
          // print("nameandip :"+ ipaaddress +username);
        }
     
      print('Logged in !');
    }








  // Future<String> getdetail() async {
  //       // stk = prefs.getString("stk_id");
  //   try{
  //     var response = await http
  //     // .get('http://192.168.1.50/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select stk_id,stk_name from stk_stocks order by 2');
  //     // .get("https://www.json-generator.com/api/json/get/bOpGzigKOG?indent=2");
  //         .get("http://$_ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20item_id,item_name%20from%20stk_items");
  //     var res= await http.
  //     get("http://$_ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20u_id%20,u_name%20from%20stk_unit_of_measurs");
  //     // .get("http://192.168.1.50/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20emp_id%20,emp_name%20from%20hr_emp%20where%20v_flex10%20is%20not%20null");
  //     // .get("https://jsonplaceholder.typicode.com/posts");
  //     // print(res.body);
  //     // print(response.body);
  //     var resp = await http.
  //     get("http://$_ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20curr_code,curr_name%20from%20currencies%20order%20by%201");
  //     payload = payloadFromJson(response.body);
  //     payload2 = payloadFromJson(res.body);
  //     payload3=payloadFromJson(resp.body);
  //     return 'success';
  //   }catch(err){
  //     print(err);
  //     throw err;

  //   }



  ///// Edited /////

  List<Item> _allItems = [];
  List<Item> get allItems => _allItems;

  List<ItemUnit> _allItemsUnit = [];
  List<ItemUnit> get allItemsUnit => _allItemsUnit;

  List<DetailWidget> choosedDetailsWidget = [];

  void createDetailsWidget() {

  TextEditingController expiryController = TextEditingController();
  TextEditingController quntityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

    DetailWidget _newWidget = DetailWidget(
      _allItems,
      _allItemsUnit,
      expiryController,
      quntityController,
      priceController,
      _allItems[0],
      _allItemsUnit[0]
    );
    choosedDetailsWidget.add(_newWidget);
  }


  getItems() async {

    http.Response _res = await http.get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20item_id,item_name%20from%20stk_items");

    Map<String, dynamic> _data = json.decode(_res.body);

    _data['data'].forEach((i) {
      Item _newItem = Item(i['item_id'], i['item_name']);
      _allItems.add(_newItem);
    });
    notifyListeners();
  }


  getItemsUnit() async {

    http.Response _res = await http.get("http://$ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20u_id%20,u_name%20from%20stk_unit_of_measurs");

    Map<String, dynamic> _data = json.decode(_res.body);

    _data['data'].forEach((i) {
      ItemUnit _newItemUnit = ItemUnit(i['u_id'], i['u_name']);
      _allItemsUnit.add(_newItemUnit);
    });
    notifyListeners();
  }

  Future<Map<String, dynamic>> getMoreData() async {

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var stk_id = prefs.getString('stk_id');

      Map<String, dynamic> _data = {
        'org_id' : 1,
        'comp_code' : 1,
        'branch_code' : 1,
        'tr_id' : 0
      };

      http.Response _moreData = await http.get('http://$_ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20(select%20org_id%20from%20branches%20where%20comp_code=b.comp_code%20and%20branch_code=b.branch_code)%20org_id,comp_code,branch_code%20from%20branches%20b%20where%20comp_code=(select%20stk_cmp_code%20from%20stk_stocks%20where%20stk_id=$stk_id)%20and%20branch_code=(select%20stk_br_code%20from%20stk_stocks%20where%20stk_id=$stk_id)');

      Map<String, dynamic> _moreDecoedData = json.decode(_moreData.body);

      http.Response _trId = await http.get('http://$_ipaaddress/php_rest_myblog/api/data/dyn_sel.php?user=view&password=1&select=select%20create_id(%27sal_ord_h%27,%27tr_id%27)%20tr_id%20from%20dual');
      
      _data['org_id'] = _moreDecoedData['data'][0]['org_id'];
      _data['comp_code'] = _moreDecoedData['data'][0]['comp_code'];
      _data['branch_code'] = _moreDecoedData['data'][0]['branch_code'];
      _data['tr_id'] = json.decode(_trId.body)['data'][0]['tr_id'];

      return _data;
    }catch(e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> createListofObj() async {

    Map<String, dynamic> _data = await getMoreData();

    List<Map<String, dynamic>> _finalData = [];

    int lineNum = 0;

    for(DetailWidget i in choosedDetailsWidget) {
      lineNum++;
      Map<String, dynamic> _newObj = {
        "org_id":  _data['org_id'],
        "comp_code":  _data['comp_code'],
        "branch_code": _data['branch_code'],
        "line_no": lineNum,
        "item_id": i.selectedItem.itemId,
        "u_id": i.selectedItemUnit.uId,
        "u_price": int.parse(i.priceController.text),
        "u_conv_price": int.parse(i.priceController.text),
        "ord_qty": int.parse(i.quntityController.text),
        "ord_conv_qty": int.parse(i.quntityController.text),
        "ord_cost": int.parse(i.priceController.text),
        "ord_conv_cost": int.parse(i.priceController.text),
        "created_user":"view",
        "created_date":i.expiryController.text,
        "tr_id": _data['tr_id']
      };
      _finalData.add(_newObj);
    }

    return _finalData;
  }
  
  bool isSendDetailDataLoading = false;

  Future<bool> sendDetailsData() async {

    isSendDetailDataLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> _data = await createListofObj();

    http.Response _res = await http.post(
      'http://$_ipaaddress/php_rest_myblog/api/data/ins_tab.php?user=view&password=1&table=sal_ord_d',
      headers: {"content-type": "application/json"},
      body: json.encode(_data)
    );

    print('---------- ${_res.body}');

    if(_res.statusCode == 200) {
      isSendDetailDataLoading = true;
      notifyListeners();
      return true;
    }else{
      isSendDetailDataLoading = false;
      notifyListeners();
      return false;
    }

  }


    ///// Edited /////

}

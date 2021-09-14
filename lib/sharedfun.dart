
import 'package:shared_preferences/shared_preferences.dart';



saveDataLocal(String key, String value) async {

  SharedPreferences _save = await SharedPreferences.getInstance();
  _save.setString(key, value);
}



Future<bool> getLocalData(String key) async {

  SharedPreferences _get = await SharedPreferences.getInstance();
  String data = _get.getString(key);

  if(data == null) {
    return false;
  }else{
    return true;
  }
}


clearData() async {

  SharedPreferences _clear = await SharedPreferences.getInstance();
  _clear.clear();
}



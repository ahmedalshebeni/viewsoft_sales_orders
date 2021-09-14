    import 'package:flutter/cupertino.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter/widgets.dart';
    import 'package:shared_preferences/shared_preferences.dart';

    import 'Setting.dart';

    class LeaveHistory extends StatefulWidget {
      @override
      _LeaveHistoryState createState() => _LeaveHistoryState();
    }

    TextEditingController showip = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    class _LeaveHistoryState extends State<LeaveHistory> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: new AppBar(
              backgroundColor: Colors.deepPurple,
              title: new Text('ChangeSetting Page')),
          body: new Container(
            child: Column(
              children: [
                new TextField(
                  style: TextStyle(fontSize: 18.0, color: Colors.deepPurple),
                  controller: showip,
                  decoration: InputDecoration(
                      icon: new Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                        size: 20.0,
                      ),
                      hintText: 'Your address'),
                  keyboardType: TextInputType.number,
                ),
               new TextField(
                  style: TextStyle(fontSize: 18.0, color: Colors.deepPurple),
                  controller: _passwordController,
                  decoration: InputDecoration(
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.deepPurple,
                        size: 20.0,
                      ),
                      hintText: 'Reset new password'),
                  obscureText: true,
                ),
                Container(
                    child: new RaisedButton(
                      onPressed: getpref,
                      child: new Text('get ip '),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                    )),
              ],
            ),
          ),
          bottomNavigationBar:  Container(
              child: new RaisedButton(
                onPressed: setpref,
                child: new Text('save changes'),
                color: Colors.deepPurple,
                textColor: Colors.white,
              )),
        );
      }
    }

    getpref() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var adress = prefs.getString("address");
      showip.text = adress;

      print(adress);
    }
    setpref() async {
      SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
      sharedPreferences.setString('address', showip.text);
      sharedPreferences.setString('password', _passwordController.text);
      print(_passwordController.text);
    }
    getpass()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var password= prefs.getString("password");
      print(password);
    }
    setpass() async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('password', _passwordController.text);
      WidgetsFlutterBinding.ensureInitialized();

    }
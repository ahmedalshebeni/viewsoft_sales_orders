import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viewsoft_hr/providers/test_provider.dart';




class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}
TextEditingController ipaddress = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();
  TextEditingController _userController = new TextEditingController();
class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.deepPurple,
          title: new Text('Setting Page')
      ),
      body: new Container(
        child:Column (
          children: [
            new TextField(
              style: TextStyle(fontSize: 18.0, color: Colors.deepPurple),
              controller: ipaddress,
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
                controller: _userController,
                decoration: InputDecoration(
                    icon: new Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                      size: 20.0,
                    ),
                    hintText: 'Your Name'),
                keyboardType: TextInputType.number,
              ),
            Container(
           child:  new RaisedButton(
                  onPressed: (){
                    Provider.of<TestProvider>(context,listen: false).onLogin(_userController.text,ipaddress.text);
                  },
                  child:  new Text('login' ),
             color: Colors.deepPurple,
             textColor: Colors.white,)
            ),
            Container(
              margin: EdgeInsets.only(left: 73.0),
              // child: TextButton(
              //     onPressed: () => {
              //      Navigator.of(context).pushNamed('/home')
              //     },
              //     child: Text("Next")),
            )
          ],
        )

      ),
    );
  }
}



// getpref() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var adress= prefs.getString("address");
//   print(adress);

// }


import 'package:flutter/material.dart';
import 'package:viewsoft_hr/refrence/shared.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  String email = "";
  String username = "";

  ProfileState() {
    MySharedPreferences.instance
        .getStringValue("email")
        .then((value) => setState(() {
      email = value;
    }));
    MySharedPreferences.instance
        .getStringValue("username")
        .then((value) => setState(() {
      username = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Hello, " + username,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Text(
                  email,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 80),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: RaisedButton(
                      color: Colors.grey,
                      child: Text("Logout",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: () {
                        MySharedPreferences.instance.removeAll();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viewsoft_hr/providers/test_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LeaveRequest2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp( home: LeaveRequest(),
    );
  }
}

class LeaveRequest extends StatefulWidget {
  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  // String txt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.deepPurple, title: new Text('Main Page')),
      body: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Side menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('img/viewsoft.png'))),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('MainPage'),
              onTap: () {
                context.read<TestProvider>().getItems();
                context.read<TestProvider>().getItemsUnit();
                Navigator.of(context).pushNamed('/main');},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('ChangeSetting'),
              onTap: () =>{Navigator.of(context).pushNamed('/Third')},
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('BasicData'),
              onTap: () =>{
                Navigator.of(context).pushNamed('/Five')
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('LogOut'),
              onTap:() {
                Provider.of<TestProvider>(context,listen: false).logout();
              }            ),
          ],
        ),
      ),
    );
  }
}

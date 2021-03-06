import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'Models/Equipment.dart';

class RequiredEditEquipments extends StatelessWidget {
  final Equipment equipment;
  final Icon _logoutIcon = new Icon(Icons.logout);
  RequiredEditEquipments(this.equipment);

  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Equipment"),
        actions: <Widget>[
          IconButton(
            icon: _logoutIcon,
            onPressed: () =>
                context.read<UserLoginSession>().logoutButtonOnPressed(context),
            tooltip: "Logout",
          ),
        ]
      ),
      body: new Column(
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "Equipment:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              // child: new Text(
              //   "Oxygen Tank",
              //   style: TextStyle(fontSize: 20.0),
              //   textAlign: TextAlign.center,
              // ),
            ),
          ]),
          Row(children: <Widget>[
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "Very Urgent:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "3",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          Row(children: <Widget>[
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "Urgent:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "4",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          Row(children: <Widget>[
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "Regular Needs:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "4",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
            Container(
              height: 50.0,
              margin: EdgeInsets.all(10),
              //  padding: EdgeInsets.all(30),
              // width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(builder: (context) => Detail("")),
                  //);
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

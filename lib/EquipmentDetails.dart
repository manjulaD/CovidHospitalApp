import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'EquipmentList.dart';

class EquipmentDetails extends StatelessWidget {
  final String hospitalName;
  EquipmentDetails(this.hospitalName);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Equipment Details"),
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
              child: new Text(
                "Oxygen Tank",
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
                "Equipment:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "Oxygen Tank",
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
                "Equipment:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                "Oxygen Tank",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          Container(
            height: 50.0,
            margin: EdgeInsets.all(10),
            //  padding: EdgeInsets.all(30),
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EquipmentList(hospitalName)),
                );
              },
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'EquipmentList.dart';
import 'EditEquipments.dart';
import 'Models/Equipment.dart';

class EquipmentDetails extends StatelessWidget {
  final Equipment equipment;
  EquipmentDetails(this.equipment);

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
                equipment.name,
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
                equipment.veryUrgent,
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
                equipment.urgent,
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
                equipment.regularNeeds,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditEquipments(equipment)),
                  );
                },
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.all(10),
              //  padding: EdgeInsets.all(30),
              // width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => EquipmentList(hospitalName)),
                  // );
                },
                child: Text(
                  'Delete',
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

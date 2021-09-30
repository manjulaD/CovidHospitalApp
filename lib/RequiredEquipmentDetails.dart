import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RequiredEquipmentList.dart';
import 'RequiredEditEquipments.dart';
import 'Models/Equipment.dart';

class RequiredEquipmentDetails extends StatelessWidget {
  final Equipment equipment;
  RequiredEquipmentDetails(this.equipment);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Required Equipment Details"),
      ),
      body: new Column(
        children: <Widget>[
          //

          Container(
            // color: Colors.green,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: new Text(
              equipment.name,
              style: TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ),
          Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                Flexible(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                  Text("Very Urgent", style: new TextStyle(color: Colors.red, fontSize: 13.0)),
                  Text(equipment.veryUrgent, style: new TextStyle(color: Colors.redAccent, fontSize: 16.0)),
                ])),
                Flexible(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                  Text("Urgent", style: new TextStyle(color: Colors.orange, fontSize: 13.0)),
                  Text(equipment.urgent, style: new TextStyle(color: Colors.orangeAccent, fontSize: 16.0)),
                ])),
                Flexible(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                  Text("Regular Needs", style: new TextStyle(color: Colors.blue, fontSize: 13.0)),
                  Text(equipment.regularNeeds, style: new TextStyle(color: Colors.blueAccent, fontSize: 16.0)),
                ])),
              ]),
            ),
            Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                      Text("Current At Hand", style: new TextStyle(color: Colors.indigo, fontSize: 13.0)),
                      Text(equipment.currentAtHandQuantity, style: new TextStyle(color: Colors.indigo, fontSize: 16.0)),
                    ])),

                    Flexible(
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                      Text("Excess Qty", style: new TextStyle(color: Colors.green, fontSize: 13.0)),
                      Text(equipment.excessQuantity, style: new TextStyle(color: Colors.green, fontSize: 16.0)),
                    ])),
                    //onPressed: moveToRegister,
                  ],
                ))
          ]),

          //
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
                    MaterialPageRoute(builder: (context) => RequiredEditEquipments(equipment)),
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

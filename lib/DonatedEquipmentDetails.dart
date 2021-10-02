import 'package:flutter/material.dart';
import 'DonatedEquipmentList.dart';
import 'Models/DonatedEquipment.dart';

class DonatedEquipmentDetails extends StatelessWidget {
  final DonatedEquipment equipment;
  DonatedEquipmentDetails(this.equipment);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Required Equipment Details"),
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
                equipment.instrumentName,
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
                "Quantity:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                equipment.quantity.toString(),
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
                "status:",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              // color: Colors.green,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: new Text(
                equipment.status,
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
                   // context,
                  //  MaterialPageRoute(builder: (context) => RequiredEditEquipments(equipment)),
                  //);
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'RequiredEquipmentList.dart';
import 'DonatedEquipmentList.dart';
import 'main.dart';

class HospitalDetail extends StatelessWidget {
  final Map<String, dynamic> hospitalDetails;
  final Icon _logoutIcon = new Icon(Icons.logout);

  HospitalDetail(this.hospitalDetails);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> hospitalAddress = hospitalDetails["address"];
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: _logoutIcon,
            onPressed: () =>
              context.read<UserLoginSession>().logoutButtonOnPressed(context),
            tooltip: "Logout",
          ),
        ],
        title: new Text("Hospital Details"),
      ),
      body: new Column(
        children: <Widget>[
          Container(
            // color: Colors.green,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: new Text(
              "${hospitalDetails["hospitalName"]}",
              style: TextStyle(fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              // height: 5,
              width: double.infinity,
              //color: Colors.red,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                    ),
              ),
              child: new Column(
                children: [
                  new Text(
                    hospitalAddress["street"] == null ? "Street" : hospitalAddress["street"],
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  new Text(
                    hospitalAddress["city"] == null ? "City" : hospitalAddress["city"],
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  new Text(
                    hospitalAddress["districtName"] == null ? "District" : hospitalAddress["districtName"],
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                ],
              )),

          Container(
            height: 50.0,
            margin: EdgeInsets.all(10),
            //  padding: EdgeInsets.all(30),
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequiredEquipmentList(hospitalDetails)),
                );
              },
              child: Text(
                'Required Equipments',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
          Container(
            height: 50.0,
            margin: EdgeInsets.all(10),
            //padding: EdgeInsets.all(30),
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonatedEquipmentList(hospitalDetails)),
                );
              },
              child: Text(
                'Donated Equipments',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

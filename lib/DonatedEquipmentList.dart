import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'DonatedEquipmentDetails.dart';
import 'Models/DonatedEquipment.dart';
import 'LogOut.dart';

class DonatedEquipmentList extends StatefulWidget {
  final Map<String, dynamic> hospitalDetails;
  DonatedEquipmentList(this.hospitalDetails);
  @override
  DonatedEquipmentState createState() => new DonatedEquipmentState(hospitalDetails);
}


class DonatedEquipmentState extends State<DonatedEquipmentList> {
  final Map<String, dynamic> hospitalDetails;

  List data = [];
  //for search bar
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";
  List<DonatedEquipment> filteredEquipments = [];
  Icon _searchIcon = new Icon(Icons.search);
  Icon _logoutIcon = new Icon(Icons.logout);

  Widget _appBarTitle = new Text('Donated Equipments');
  List<DonatedEquipment> equipments = [];
  DonatedEquipmentState(this.hospitalDetails) {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredEquipments = equipments;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          print(_searchText);
        });
      }
    });
  }

  Future<List<DonatedEquipment>> getData() async {
    String _subURL = '/dev/hospitals/' + '${hospitalDetails["hospitalId"]}'+ '/donated-instruments';
    var _url =  Uri.https('vs0syenr45.execute-api.ap-southeast-1.amazonaws.com', _subURL, {});
    var response = await http.get(_url, headers: {
      //"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    for (var i = 0; i < data.length; i++) {
      equipments.add(new DonatedEquipment(data[i]["instrumentCode"], data[i]["instrumentName"], data[i]["quantity"],
          data[i]["donatedDate"].toString(), data[i]["status"], data[i]["comments"], data[i]["hospital"], data[i]["donorOrg"]));
    }
    filteredEquipments = equipments;
    print(data[0]["instrumentName"]);

    return equipments;
  }

  @override
  void initState() {
    this.getData();
    filteredEquipments = equipments;
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Donated Equipments - ' + '${hospitalDetails["hospitalName"]}');
        filteredEquipments = equipments;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      List<DonatedEquipment> tempList = [];
      for (int i = 0; i < equipments.length; i++) {
        if (equipments[i].instrumentName.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(equipments[i]);
        }
      }
      filteredEquipments = tempList;
    }
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
            tooltip: "Search",
          ),
          IconButton(
            icon: _logoutIcon,
            onPressed: () {
              new LogOut().logoutButtonOnPressed(context);
            },
            tooltip: "Logout",
          ),
        ],
        title: _appBarTitle,
        centerTitle: true,
        elevation: 0,
      ),
      body: new ListView.builder(
        itemCount: filteredEquipments == null ? 0 : filteredEquipments.length,
        itemBuilder: (BuildContext context, int index) {
          {
            return new GestureDetector(
                onTap: () {
                  print(filteredEquipments[index].instrumentName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonatedEquipmentDetails(filteredEquipments[index])),
                  );

                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                          ),
                    ),

                    // height: 65.0,
                    alignment: FractionalOffset.center,
                    child: new Column(children: <Widget>[
                      Container(
                        // color: Colors.green,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: new Text(
                          filteredEquipments[index].instrumentName,
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                            Text("Quantity", style: new TextStyle(color: Colors.green, fontSize: 13.0)),
                            Text(filteredEquipments[index].quantity.toString(), style: new TextStyle(color: Colors.blue, fontSize: 16.0)),
                          ])),
                          Flexible(
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                            Text("Status", style: new TextStyle(color: Colors.green, fontSize: 13.0)),
                            Text(filteredEquipments[index].status, style: new TextStyle(color: Colors.blue, fontSize: 16.0)),
                          ])),
                        ],
                      ),
                      Container(margin: EdgeInsets.all(5), padding: EdgeInsets.all(5), child:
                          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                              Text("Donor Org: " + "${filteredEquipments[index].donorOrg}", style: new TextStyle(color: Colors.black54, fontSize: 16.0)),
                              Text("Date: " + "${filteredEquipments[index].donatedDate}", style: new TextStyle(color: Colors.black54, fontSize: 16.0)),
                              Text("Comments: " + "${filteredEquipments[index].comments}", style: new TextStyle(color: Colors.black54, fontSize: 16.0)),
                            ])
                        )
                    ])));
          }

        },
      ),
    );
  }
}

///

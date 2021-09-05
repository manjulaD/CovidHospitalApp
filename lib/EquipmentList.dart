import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Detail.dart';

class EquipmentList extends StatefulWidget {
  final String hospitalName;
  EquipmentList(this.hospitalName);
  @override
  EquipmentState createState() => new EquipmentState();
}

class Equipment {
  final name;
  final urgency;
  final quantity;

  Equipment(this.name, this.urgency, this.quantity);
}

class EquipmentState extends State<EquipmentList> {
  List data;
  List<Equipment> equipments = [];
  ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredEquipments = equipments;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  //for search bar
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Equipment> filteredEquipments = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');

  Future<List<Equipment>> getData() async {
    var response = await http.get(Uri.encodeFull("https://myhospitalsapi.aihw.gov.au/api/v0/retired-myhospitals-api/hospitals"), headers: {
      //"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    for (var i = 0; i < data.length; i++) {
      equipments.add(new Equipment(data[i]["name"], data[i]["name"], data[i]["name"]));
    }
    filteredEquipments = equipments;
    print(data[1]["name"]);

    return equipments;
  }

  @override
  void initState() {
    this.getData();
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
        this._appBarTitle = new Text('Search Example');
        filteredEquipments = equipments;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredEquipments.length; i++) {
        if (filteredEquipments[i].name.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredEquipments[i]);
        }
      }
      filteredEquipments = tempList;
    }
    return new Scaffold(
      appBar: new AppBar(title: new Text("Required Equipments"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: filteredEquipments == null ? 0 : filteredEquipments.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return new Container(
              margin: EdgeInsets.all(5),
              color: Colors.blueAccent,
              height: 50.0,
              alignment: FractionalOffset.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(child: Text("Equipment")),
                  Flexible(child: Text("Urgency")),
                  Flexible(child: Text("Quantity")),
                ],
              ),
            );
          } else {
            return new Container(
              margin: EdgeInsets.all(5),
              color: Colors.blueAccent,
              height: 65.0,
              alignment: FractionalOffset.center,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: new Text(filteredEquipments[index].name, style: new TextStyle(color: Color(0xFF2E3233))),
                  ),
                  Flexible(
                    child: new Text("Urgent", style: new TextStyle(color: Color(0xFF2E3233))),
                  ),

                  Flexible(
                    child: new Text("7", style: new TextStyle(color: Color(0xFF2E3233))),
                  ),
                  //onPressed: moveToRegister,
                ],
              ),
            );
          }

          // return Card(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(40), // if you need this
          //     side: BorderSide(
          //       color: Colors.grey.withOpacity(0.2),
          //       width: 1,
          //     ),
          //   ),
          //   child: GestureDetector(
          //     child: new Text(data[index]["name"]),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => Detail(data[index]["name"])),
          //       );
          //     },
          //   ),
          // );

          //  );
        },
      ),
    );
  }
}

///

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'EquipmentDetails.dart';

class EquipmentList extends StatefulWidget {
  final String hospitalName;
  EquipmentList(this.hospitalName);
  @override
  EquipmentState createState() => new EquipmentState();
}

class Equipment {
  final name;
  final urgent;
  final veryUrgent;
  final regularNeeds;

  Equipment(this.name, this.urgent, this.veryUrgent, this.regularNeeds);
}

class EquipmentState extends State<EquipmentList> {
  List data;
  //for search bar
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Equipment> filteredEquipments = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');
  List<Equipment> equipments = [];
  EquipmentState() {
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

  Future<List<Equipment>> getData() async {
    var response = await http.get(Uri.encodeFull("https://myhospitalsapi.aihw.gov.au/api/v0/retired-myhospitals-api/hospitals"), headers: {
      //"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    for (var i = 0; i < data.length; i++) {
      equipments.add(new Equipment(data[i]["name"], data[i]["name"], data[i]["name"], data[i]["name"]));
    }
    filteredEquipments = equipments;
    print(data[1]["name"]);

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
        this._appBarTitle = new Text('Equipments List');
        filteredEquipments = equipments;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      List<Equipment> tempList = [];
      for (int i = 0; i < equipments.length; i++) {
        if (equipments[i].name.toLowerCase().contains(_searchText.toLowerCase())) {
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
          )
        ],
        title: _appBarTitle == null ? Text('Choose a Location') : _appBarTitle,
        centerTitle: true,
        elevation: 0,
      ),
      body: new ListView.builder(
        itemCount: filteredEquipments == null ? 0 : filteredEquipments.length,
        itemBuilder: (BuildContext context, int index) {
          // if (index == 0) {
          //   return new Container(
          //     margin: EdgeInsets.all(5),
          //     color: Colors.blueAccent,
          //     //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          //     height: 50.0,
          //     alignment: FractionalOffset.center,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         Flexible(child: Text("Equipment")),
          //         Flexible(child: Text("Urgency")),
          //         Flexible(child: Text("Quantity")),
          //       ],
          //     ),
          //   );
          // } else
          {
            return new GestureDetector(
              onTap: () {
                print(filteredEquipments[index].name);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EquipmentDetails("")),
                );
              },
              child: Container(
                margin: EdgeInsets.all(5),

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                      ),
                ),

                // height: 65.0,
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

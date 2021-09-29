import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'RequiredEquipmentDetails.dart';
import 'Models/Equipment.dart';

class RequiredEquipmentList extends StatefulWidget {
  final Map<String, dynamic> hospitalDetails;
  RequiredEquipmentList(this.hospitalDetails);
  @override
  RequiredEquipmentState createState() => new RequiredEquipmentState(hospitalDetails);
}

// class Equipment {
//   final name;
//   final urgent;
//   final veryUrgent;
//   final regularNeeds;

//   Equipment(this.name, this.urgent, this.veryUrgent, this.regularNeeds);
// }

class RequiredEquipmentState extends State<RequiredEquipmentList> {
  final Map<String, dynamic> hospitalDetails;

  List data;
  //for search bar
  final TextEditingController _filter = new TextEditingController();

  String _searchText = "";
  List<Equipment> filteredEquipments = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Equipments');
  List<Equipment> equipments = [];
  RequiredEquipmentState(this.hospitalDetails) {
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
    var response = await http.get(Uri.encodeFull("https://vs0syenr45.execute-api.ap-southeast-1.amazonaws.com/dev/hospitals/4/required-instruments"), headers: {
      //"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    for (var i = 0; i < data.length; i++) {
      equipments.add(new Equipment(data[i]["instrumentName"], data[i]["urgentNeedQuantity"].toString(), data[i]["veryUrgentNeedQuantity"].toString(), data[i]["regularNeedQuantity"].toString()));
    }
    filteredEquipments = equipments;
    print(data[1]["instrumentName"]);

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
          {
            return new GestureDetector(
                onTap: () {
                  print(filteredEquipments[index].name);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequiredEquipmentDetails(filteredEquipments[index])),
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
                          filteredEquipments[index].name,
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                            Text("Very Urgent", style: new TextStyle(color: Colors.red, fontSize: 13.0)),
                            Text(filteredEquipments[index].veryUrgent, style: new TextStyle(color: Colors.blue, fontSize: 16.0)),
                          ])),
                          Flexible(
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                            Text("Urgent", style: new TextStyle(color: Colors.orange, fontSize: 13.0)),
                            Text(filteredEquipments[index].urgent, style: new TextStyle(color: Colors.blue, fontSize: 16.0)),
                          ])),

                          Flexible(
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                            Text("Regular Needs", style: new TextStyle(color: Colors.green, fontSize: 13.0)),
                            Text(filteredEquipments[index].regularNeeds, style: new TextStyle(color: Colors.blue, fontSize: 16.0)),
                          ])),
                          //onPressed: moveToRegister,
                        ],
                      ),
                    ])));
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

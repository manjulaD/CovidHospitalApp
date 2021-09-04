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
  List<Equipment> equipments;

  Future<List<Equipment>> getData() async {
    var response = await http.get(Uri.encodeFull("https://myhospitalsapi.aihw.gov.au/api/v0/retired-myhospitals-api/hospitals"), headers: {
      //"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    for (var i = 0; i < data.length; i++) {
      equipments.add(new Equipment(data[i]["name"], data[i]["isPublic"], data[i]["code"]));
    }
    print(data[1]["name"]);

    return equipments;
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Required Equipments"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: equipments == null ? 0 : equipments.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 150,
            child: Card(
              color: Colors.orange,
              child: Row(
                children: [
                  Expanded(
                    flex: 33,
                    child: Image.network(
                      'https://picsum.photos/250?image=9',
                    ),
                  ),
                  Expanded(
                    flex: 66,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Center(child: Text(equipments[index].name)),
                        ),
                        Expanded(flex: 25, child: Text(equipments[index].urgency)),
                        Expanded(flex: 25, child: Text(equipments[index].quantity)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );

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

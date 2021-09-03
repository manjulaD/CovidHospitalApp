import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Detail.dart';

class EquipmentList extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<EquipmentList> {
  List data;

  Future<String> getData() async {
    var response = await http.get(Uri.encodeFull("https://myhospitalsapi.aihw.gov.au/api/v0/retired-myhospitals-api/hospitals"), headers: {
      //"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    print(data[1]["name"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: GestureDetector(
              child: new Text(data[index]["name"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Detail(data[index]["name"])),
                );
              },
            ),
          );

          //  );
        },
      ),
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'HospitalDetail.dart';
import 'main.dart';

class HospitalList extends StatefulWidget {
  @override
  HospitalListState createState() => new HospitalListState();
}

class HospitalListState extends State<HospitalList> {
  List data = [];
  Icon _logoutIcon = new Icon(Icons.logout);

  Future<void> getData() async {
    String _idToken = context.read<UserLoginSession>().idToken;
    String _usrRole = context.read<UserLoginSession>().userAttrib['custom:role'];
    print('usrRole: $_usrRole');

    String _subURL = '/dev/hospitals/';

    if (_usrRole == 'COORDINATOR')
      _subURL = _subURL + context.read<UserLoginSession>().userAttrib['custom:hospitalId'].toString();

    var _url =  Uri.https('vs0syenr45.execute-api.ap-southeast-1.amazonaws.com', _subURL, {});
    var response = await http.get(_url, headers: {
      "Authorization": _idToken
    });

    this.setState(() {
      data = json.decode(response.body);
    });

    if (_usrRole == 'COORDINATOR')
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HospitalDetail(data[0]))
      );
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: _logoutIcon,
              onPressed: () {
                context.read<UserLoginSession>().logoutButtonOnPressed(context);
              },
              tooltip: "Logout",
            ),
          ],
          title: new Text("Hospital List"),
          backgroundColor: Colors.blue),
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
              child: new Text(data[index]["hospitalName"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalDetail(data[index])),
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

import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String hospitalName;
  Detail(this.hospitalName);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hospital Details"),
      ),
      body: new Column(
        children: <Widget>[
          Container(
            color: Colors.green,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: new Text(
              "${hospitalName}",
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            // height: 5,
            width: double.infinity,
            color: Colors.red,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: new Text(
              "Contact Details",
              style: TextStyle(fontSize: 10.0),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

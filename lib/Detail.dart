import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            // color: Colors.green,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: new Text(
              "${hospitalName}",
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
                    "Hospital Coordinator",
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  new Text(
                    "Dr. Abcd Efgh",
                    style: TextStyle(fontSize: 15.0),
                    textAlign: TextAlign.start,
                  ),
                  new Text(
                    "0717904023",
                    style: TextStyle(fontSize: 15.0),
                    textAlign: TextAlign.start,
                  ),
                  new Text(
                    "test@gmail.com",
                    style: TextStyle(fontSize: 15.0),
                    textAlign: TextAlign.start,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

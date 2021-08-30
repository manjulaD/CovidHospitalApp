import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String hospitalName;
  Detail(this.hospitalName);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Details"),
      ),
      body: new Column(
        children: <Widget>[
          new Text("${hospitalName}", style: TextStyle(fontSize: 20.0)),
        ],
      ),
    );
  }
}

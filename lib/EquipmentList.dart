import 'package:flutter/material.dart';

class EquipmentList extends StatelessWidget {
  final String hospitalName;
  EquipmentList(this.hospitalName);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Equipments"),
      ),

      /// body: new Text("List");
    );
  }
}

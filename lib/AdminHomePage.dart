import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'main.dart';


class AdminHomePage extends StatefulWidget {

  AdminHomePage();

  @override
  AdminHomePageState createState() => new AdminHomePageState();
}


class AdminHomePageState extends State<AdminHomePage> {

  Icon _logoutIcon = new Icon(Icons.logout);
  Widget _appBarTitle = new Text('Equipments');

  Future<void> getData() async {
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
            onPressed: () =>
                context.read<UserLoginSession>().logoutButtonOnPressed(context),
            tooltip: "Logout",
          ),
        ],
        title: _appBarTitle,
        centerTitle: true,
        elevation: 0,
      ),
      body: new Column()
    );
  }
}

///

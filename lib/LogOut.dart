import 'package:flutter/material.dart';
import 'main.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

class LogOut extends StatelessWidget {

  Icon _logoutIcon = new Icon(Icons.logout);

  void logoutButtonOnPressed(BuildContext context) {
    try{
      Amplify.Auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(),
        ),
      );
    }
    on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Logout"), backgroundColor: Colors.blue,
            actions: <Widget>[]
        ));
  }
}


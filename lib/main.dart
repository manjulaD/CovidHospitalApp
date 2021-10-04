import 'dart:async';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginPage.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserLoginSession()),
        ],
        child: new MaterialApp(home: new LoginPage()),
      )
  );
}

class UserLoginSession with ChangeNotifier {
  Map<String, dynamic>  _userAttrib = {};
  String _idToken = '';

  Map<String, dynamic> get userAttrib => _userAttrib;
  String get idToken => _idToken;

  void refresh(String token, List<AuthUserAttribute> userAttrib) {
    _idToken = token;
    //print('idToken: $_idToken');

    userAttrib.forEach((element) {
      //print('key: ${element.userAttributeKey}; value: ${element.value}');
      _userAttrib['${element.userAttributeKey}'] = element.value;
    });

    notifyListeners();
  }

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
}

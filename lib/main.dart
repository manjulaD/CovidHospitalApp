import 'dart:async';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'amplifyconfiguration.dart';

import 'package:flutter/material.dart';
import 'HospitalList.dart';


void main() {
  runApp(new MaterialApp(home: new LoginPage()));
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (!Amplify.isConfigured)
      _configureAmplify();
  }

  void _configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    // AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([authPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
      appBar: new AppBar(title: new Text("Login"), backgroundColor: Colors.blue),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                ),
          ),
          child: new Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: "UserName"),
                controller: _userController,
                validator: (value) =>
                value == null ? "Password is invalid" : null,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                controller: _passwordController,
                validator: (value) =>
                value == null ? "Password is invalid" : null,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("LOG IN"),
                onPressed: () => _loginButtonOnPressed(context),
              ),
              OutlinedButton(
                child: Text("Create New Account"),
                onPressed: () => _gotoSignUpScreen(context),
              ),
          ])
      ))
    );
  }

  Future<void> _loginButtonOnPressed(BuildContext context) async {

      if (_formKey.currentState!.validate()) {
        try{
          final user = _userController.text.trim();
          final password = _passwordController.text;

          final response = await Amplify.Auth.signIn(
            username: user,
            password: password,
          );

          if (response.isSignedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HospitalList(),
              ),
            );
          }
        }
        on AuthException catch (e) {
          Amplify.Auth.signOut();
          print(e.message);
        }
      }
  }

  void _gotoSignUpScreen(BuildContext context) {
    /* Navigator.push(
        context,
       MaterialPageRoute(
        builder: (_) => SignUpScreen(),
      ),
    ); */
  }
}

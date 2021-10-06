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
  List _hospitalList = [];
  //for search bar
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List _filteredHospitals = [];
  Icon _searchIcon = new Icon(Icons.search);

  Icon _logoutIcon = new Icon(Icons.logout);

  Widget _appBarTitle = new Text('Hospital List');

  HospitalListState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filteredHospitals = _hospitalList;
        });
      } else {
        setState(() {
          _searchText = _filter.text;

          List _tempList = [];
          for (int i = 0; i < _hospitalList.length; i++) {
            if (_hospitalList[i]["hospitalName"].toLowerCase().contains(_searchText.toLowerCase())) {
              _tempList.add(_hospitalList[i]);
            }
          }
          _filteredHospitals = _tempList;
        });
      }
    });
  }

  Future<void> getData() async {
    String _idToken = context.read<UserLoginSession>().idToken;
    String _usrRole = context.read<UserLoginSession>().userAttrib['custom:role'];

    String _apiHost = context.read<AppConfig>().properties['apiHost'];
    String _subURL = '/' + context.read<AppConfig>().properties['apiEnv'] + '/hospitals/';

    if (_usrRole == 'COORDINATOR')
      _subURL = _subURL + context.read<UserLoginSession>().userAttrib['custom:hospitalId'].toString();

    print('Inside HospitalList: Calling API Host=$_apiHost, subURL=$_subURL');
    var _url =  Uri.https(_apiHost, _subURL, {});
    var response = await http.get(_url, headers: {
      "Authorization": _idToken
    });

    this.setState(() {
      _hospitalList = json.decode(response.body);
      _filteredHospitals = _hospitalList;
    });

    if (_usrRole == 'COORDINATOR')
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HospitalDetail(_filteredHospitals[0]))
      );
  }

  @override
  void initState() {
    this.getData();
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Hospital List');
        _filteredHospitals = _hospitalList;
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          actions: <Widget>[
            IconButton(
              icon: _searchIcon,
              onPressed: () {
                this._searchPressed();
              },
              tooltip: "Search",
            ),
            IconButton(
              icon: _logoutIcon,
              onPressed: () {
                context.read<UserLoginSession>().logoutButtonOnPressed(context);
              },
              tooltip: "Logout",
            ),
          ],
          title: _appBarTitle,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: _filteredHospitals == null ? 0 : _filteredHospitals.length,
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
              child: new Text(_filteredHospitals[index]["hospitalName"]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalDetail(_filteredHospitals[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

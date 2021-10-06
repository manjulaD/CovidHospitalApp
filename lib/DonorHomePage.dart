import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'main.dart';
import 'HospitalDetail.dart';
import 'RequiredEquipmentByCategory.dart';

class DonorHomePage extends StatefulWidget {

  DonorHomePage();

  @override
  DonorHomePageState createState() => new DonorHomePageState();
}


class DonorHomePageState extends State<DonorHomePage> {

  Icon _logoutIcon = new Icon(Icons.logout);

  String _searchOptionValue = 'Hospital Name';
  //List _displayList = [];
  List _hospitalList = [];
  List _equipmentList = [];

  //for search bar
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List _filteredList = [];
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Hospital Requirements');

  DonorHomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          _filteredList = _getFilteredList();
        });
      }
    });
  }

  List _getFilteredList() {
    if (_searchOptionValue == 'Hospital Name') {
      List _tempList = [];
      for (int i = 0; i < _hospitalList.length; i++) {
        if (_hospitalList[i]["hospitalName"].toLowerCase().contains(_searchText.toLowerCase())) {
          _tempList.add(_hospitalList[i]);
        }
      }
      return _tempList;
    }
    else {
      return _equipmentList;
    }
  }

  Future<void> getData() async {
    String _idToken = context.read<UserLoginSession>().idToken;
    String _usrRole = context.read<UserLoginSession>().userAttrib['custom:role'];

    String _apiHost = context.read<AppConfig>().properties['apiHost'];
    String _subURL = '/' + context.read<AppConfig>().properties['apiEnv'] + '/hospitals/';

    print('Inside Donor HomePage: Calling API Host=$_apiHost, subURL=$_subURL');
    var _url =  Uri.https(_apiHost, _subURL, {});
    var respGetHospitalList = await http.get(_url, headers: {
      "Authorization": _idToken
    });

    this.setState(() {
      _hospitalList  = json.decode(respGetHospitalList.body);
      _filteredList = _hospitalList;
      _equipmentList = ['NON REBREATHING MASK','NASAL PRONGS(ADULTS)'];
    });
  }

  @override
  void initState() {
    this.getData();
  }

  void _searchIconPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Hospital Requirements');
        _filter.clear();

        if (_searchOptionValue == 'Hospital Name')
          _filteredList = _hospitalList;
        else
          _filteredList = _equipmentList;
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
              this._searchIconPressed();
            },
            tooltip: "Search",
          ),
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
      body: new Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Search By: ', style: new TextStyle(color: Colors.black, fontSize: 14.0)),
                DropdownButton<String>(
                  value: _searchOptionValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _searchOptionValue = newValue!;
                      if (_searchOptionValue == 'Hospital Name')
                        _filteredList = _hospitalList;
                      else
                        _filteredList = _equipmentList;
                    });
                  },
                  items: <String>['Hospital Name', 'Equipment Name']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      );
                    }).toList(),
                )
              ]
          )
        ),
        /*
        Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            child:
                  TextField(
                    controller: _filter,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search text',
                    ),
                    onSubmitted: (text) {
                      _searchPressed(text);   // Redraw the Stateful Widget
                    },
                  ),
        ), */

        new Expanded(child:
         new ListView.builder(
          itemCount: _filteredList == null ? 0 : _filteredList.length,
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
                child: _searchOptionValue == 'Hospital Name' ? new Text(_filteredList[index]["hospitalName"]) : new Text(_filteredList[index]),
                onTap: () {
                  if (_searchOptionValue == 'Hospital Name')
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HospitalDetail(_filteredList[index])),
                    );
                  else
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RequiredEquipmentByCategory()),
                    );
                },
              ),
            );
          },
        ),
      )

      ])
    );
  }
}

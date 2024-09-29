import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helios_flutter_julien/models/user.model.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          Text('This is a list'),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Text('This is a tile');
                }),
          )
        ],
      ),
    );
  }

  void _fetchData() async {
    var response = await http
        .get(Uri.parse('https://randomuser.me/api/?page=1&results=10'));
    var data = json.decode(response.body);
    List<dynamic> results = data['results'];
    User user = User.fromMap(results[0]);
    print(user);
  }
}

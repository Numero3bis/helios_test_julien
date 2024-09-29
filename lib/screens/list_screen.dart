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
  List<User> _userList = [];
  bool _isFetching = false;
  bool _hasUserLeft = true;
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
    _fetchData();
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          Text('This is a list'),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: _userList.length,
                itemBuilder: (context, index) {
                  return Text(_userList[index].firstName);
                }),
          )
        ],
      ),
    );
  }

  void _fetchData() async {
    setState(() {
      _isFetching = true;
    });
    var response = await http
        .get(Uri.parse('https://randomuser.me/api/?page=1&results=100'));
    var data = json.decode(response.body);
    List<dynamic> results = data['results'];
    List<User> users = results.map((user) => User.fromMap(user)).toList();
    _userList.addAll(users);
    setState(() {
      _isFetching = false;
    });
  }
}

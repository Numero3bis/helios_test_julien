import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helios_flutter_julien/components/user_tile.component.dart';
import 'package:helios_flutter_julien/models/user.model.dart';
import 'package:helios_flutter_julien/screens/user_screen.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final NUMBER_USER_BY_PAGE = 20;
  List<User> _userList = [];
  int _pageNumber = 0;
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
                itemCount: _userList.length + 1,
                itemBuilder: (context, index) {
                  return (index == _userList.length)
                      ? listStatus()
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserScreen(
                                        user: _userList[index],
                                      )),
                            );
                          },
                          child: UserTileComponent(
                            user: _userList[index],
                            index: index,
                          ),
                        );
                }),
          )
        ],
      ),
    );
  }

  Widget listStatus() {
    if (_isFetching) {
      return Center(
          child: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 50),
        width: 40.0,
        height: 40.0,
        child: const CircularProgressIndicator(),
      ));
    }
    return const Center(child: Text('....No more bad guys to catch'));
  }

  void _fetchData() async {
    setState(() {
      _isFetching = true;
    });
    var response = await http.get(Uri.parse(
        'https://randomuser.me/api/?page=${_pageNumber}&results=${NUMBER_USER_BY_PAGE}'));
    var data = json.decode(response.body);
    List<dynamic> results = data['results'];
    List<User> users = results.map((user) => User.fromMap(user)).toList();
    _userList.addAll(users);
    setState(() {
      _pageNumber = _pageNumber + 1;
      _isFetching = false;
    });
  }
}

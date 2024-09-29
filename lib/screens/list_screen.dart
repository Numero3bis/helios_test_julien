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
  List<User> _userListFiltered = [];

  int _pageNumber = 0;
  bool _isFetching = false;
  bool _hasUserLeft = true;
  final ScrollController _scrollController = ScrollController();

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
              _scrollController.position.maxScrollExtent &&
          _hasUserLeft == true &&
          _isFetching == false) {
        _fetchData();
      }
    });
    _fetchData();
  }

  @override
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 2, 13, 44),
              child: const Text('FBI watch list',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(250, 250, 235, 21), fontSize: 50))),
          Container(
            margin: EdgeInsets.all(5),
            child: TextField(
              autofocus: false,
              onChanged: (value) {
                if (value == '') {
                  setState(() {
                    _userListFiltered = _userList;
                  });
                } else {
                  List<User> filteredUser = _userList
                      .where((user) =>
                          user.city.contains(value) ||
                          user.country.contains(value) ||
                          user.firstName.contains(value) ||
                          user.lastName.contains(value) ||
                          user.crime.contains(value))
                      .toList();
                  setState(() {
                    _userListFiltered = filteredUser;
                  });
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: _userListFiltered.length + 1,
                itemBuilder: (context, index) {
                  return (index == _userListFiltered.length)
                      ? listStatus()
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserScreen(
                                        user: _userListFiltered[index],
                                      )),
                            );
                          },
                          child: UserTileComponent(
                            user: _userListFiltered[index],
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
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> results = data['results'];
      List<User> users = results.map((user) => User.fromMap(user)).toList();
      _userList.addAll(users);
      setState(() {
        _userListFiltered = _userList;
        _hasUserLeft = (users.length != 20) ? false : true;
        _pageNumber = _pageNumber + 1;
        _isFetching = false;
      });
    } else {
      setState(() {
        _isFetching = false;
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:helios_flutter_julien/models/user.model.dart';

class UserScreen extends StatelessWidget {
  User user;
  UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [Text(user.city)],
      )),
    );
  }
}

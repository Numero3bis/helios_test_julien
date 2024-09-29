import 'package:flutter/material.dart';
import 'package:helios_flutter_julien/models/user.model.dart';

class UserScreen extends StatelessWidget {
  User user;
  UserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 13, 44),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '< Back',
                        style: getTextStyle(fontSize: 15),
                      ))),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(250, 250, 235, 21),
                      width: 5.0,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(user.largePictureUrl),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Text(user.firstName, style: getTextStyle(fontSize: 30)),
              Text(user.lastName, style: getTextStyle()),
              Text("Crime : ${user.crime}", style: getTextStyle()),
              Text(
                  'If you have any information concerning this person, please contact your local FBI office or the nearest American Embassy or Consulate.',
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                      color: const Color.fromARGB(249, 219, 59, 19))),
            ],
          ),
        )));
  }

  TextStyle getTextStyle(
      {double fontSize = 20, color = const Color.fromARGB(250, 250, 235, 21)}) {
    return TextStyle(color: color, fontSize: fontSize);
  }
}

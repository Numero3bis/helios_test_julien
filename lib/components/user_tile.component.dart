// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:helios_flutter_julien/models/user.model.dart';

class UserTileComponent extends StatelessWidget {
  User user;
  int index;
  UserTileComponent({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (index % 2 == 1)
                ? const Color.fromARGB(255, 239, 242, 243)
                : Colors.white),
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
        margin: const EdgeInsets.only(left: 5, bottom: 2.5, right: 5),
        child: Row(
          children: [Text(user.firstName), Text(" ${user.lastName}")],
        ));
  }
}

import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  String usersName;
  AccountHeader({Key? key, this.usersName = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 5, right: 5),
      child: Row(children: [
        Container(
          child: const Expanded(
            flex: 1,
            child: Icon(
              Icons.account_circle_outlined,
              size: 85,
            ),
          ),
        ),
        Container(
          child: Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      'Hello,',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      usersName.toUpperCase(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

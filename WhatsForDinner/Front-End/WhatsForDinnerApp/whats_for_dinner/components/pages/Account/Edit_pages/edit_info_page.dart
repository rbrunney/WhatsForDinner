import 'package:flutter/material.dart';
import '../../../util/requests.dart';
import 'edit_info_page_password.dart';
import '../../../util/to_prev_page.dart';
import '../../../util/globals.dart' as globals;
import 'dart:convert';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage(
      {Key? key, this.editProfileInfo = "peepee", this.accountInfo = 'peepee'})
      : super(key: key);

  final String editProfileInfo;
  final String accountInfo;

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    Requests requests = Requests();

    messageController.value = TextEditingValue(
      text: widget.accountInfo,
    );

    if (!widget.editProfileInfo.contains("Password")) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const ToPrevPage(),
                Center(
                  heightFactor: 5,
                  child: Text(
                    "Edit ${widget.editProfileInfo}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle_outlined),
                        border: const OutlineInputBorder(),
                        labelText: 'Edit ${widget.editProfileInfo}'),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (messageController.text != '') {
                        Map<String, dynamic> requestBody = {
                          "id": globals.userID,
                          "name": globals.name,
                          "username": globals.username,
                          "password": globals.password,
                          "birthday": globals.birthday,
                          "email": globals.email
                        };
                        switch (widget.editProfileInfo) {
                          case "Name":
                            requestBody["name"] = messageController.text;
                            break;
                          case "Email":
                            requestBody["email"] = messageController.text;
                            break;
                          case "Birthday":
                            requestBody["birthday"] = messageController.text;
                            break;
                        }
                        requests.makePutRequest(
                            "http://10.0.2.2:8888/users/updateUser/", {
                          "email": globals.email,
                          "updateFields": requestBody
                        }).then((value) {
                          print(value);
                            requests
                              .makeGetRequest(
                                  "http://10.0.2.2:8888/users/getUser/${json.decode(value)["result"]["userID"]}")
                              .then((value) {
                            globals.name =
                                json.decode(value)["name"];
                            globals.email =
                                json.decode(value)["email"];
                            globals.birthday =
                                json.decode(value)["birthday"];
                          });
                        });
                        Navigator.of(context).pop();
                        await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    '${widget.editProfileInfo} has been Edited'),
                                content: Text(
                                    'Your ${widget.editProfileInfo} now has been changed to ${messageController.text}'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                        messageController.clear();
                      } else {
                        await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    const Text('Not all the fields are used'),
                                content: const Text(
                                    'Please, fill all the fields with information.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent, // background
                    ),
                    child: Text(
                      'Edit ${widget.editProfileInfo}',
                      style: const TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
        alignment: Alignment.center, child: const EditInfoPagePassword());
  }
}

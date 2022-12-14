import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../util/requests.dart';
import '../../util/to_prev_page.dart';
import 'code_authentication_page.dart';
import 'dart:math';
import '../../util/globals.dart' as globals;
import 'change_pass_page.dart';
import 'dart:convert';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usersEmail = TextEditingController();
    Requests requests = Requests();

    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        const ToPrevPage(),
        const Center(
          heightFactor: 5,
          child: Text(
            "Forgot Password",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: usersEmail,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Enter Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.email, color: Colors.grey)),
            )),
        Container(
            margin: const EdgeInsets.only(top: 25),
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.tealAccent, // background
                ),
                onPressed: () {
                  Random random = new Random();
                  int authenticationCode = random.nextInt(900000) + 100000;

                  requests.makePostRequest(
                      "http://10.0.2.2:8888/users/forgotPassword/", {
                    "email": usersEmail.text,
                    "authCode": authenticationCode
                  }).then((value) {
                    print(value);
                    globals.userID = json.decode(value)["id"];
                    globals.name = json.decode(value)["name"];
                    globals.username = json.decode(value)["username"];
                    globals.email = json.decode(value)["email"];
                    globals.birthday = json.decode(value)["birthday"];
                  });

                  Navigator.push(
                      context,
                      PageTransition(
                          child: CodeAuthentication(
                            generatedCode: authenticationCode,
                            userEmail: usersEmail.text,
                            pageAfterAuthenticated: ChangePassPage(
                              userEmail: usersEmail.text,
                            ),
                          ),
                          type: PageTransitionType.bottomToTop));
                },
                child: const Text('Submit',
                    style: TextStyle(color: Colors.black))))
      ],
    )));
  }
}

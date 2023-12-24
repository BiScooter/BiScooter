// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/input.dart';
import "package:flutter/material.dart";
// TODO: remove the commenting when the server is ready
// import 'dart:convert';
// import 'package:biscooter/services/user.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formController = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  void login() async {
    FocusScope.of(context).unfocus();

    // if the form is valid go and send the login request
    // TODO: activate this when the server is ready
    if (_formController.currentState!.validate()) {
      // try {
      //   // send a login request to the server
      //   Response response = await post(
      //     Uri.parse("http://localhost:3000/login"),
      //     body: {
      //       "username": _username.text,
      //       "password": _password.text,
      //     },
      //   );

      //   // check if the login was successful
      //   if (response.statusCode == 200) {
      //     // Decode the response body
      //     Map<String, dynamic> responseData = jsonDecode(response.body);
      //     // set the user service
      //     User.setUserService(
      //       responseData['id'],
      //       responseData['firstName'],
      //       responseData['middleName'],
      //       responseData['lastName'],
      //       responseData['invitationCode'],
      //       responseData['profileImage'],
      //       responseData['balance'],
      //       responseData['ridingTime'],
      //     );
      //     // set the login status to true
      //     User.setLoggedIn();
      //     // go to the profile page
      //     if (mounted) {
      //       Navigator.of(context).pushNamedAndRemoveUntil(
      //           "/profile", (Route<dynamic> route) => false);
      //     }
      //   } // if the login was not successful
      //   else {
      //     Fluttertoast.showToast(
      //       msg: "Something went wrong",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16,
      //     );
      //   }
      // } catch (e) {
      //   debugPrint(e.toString());
      // }

      // TODO: remove this line when the server is ready
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/profile", (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Log in"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // the styling
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceTint,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [
              0.03,
              0.2,
            ],
          ),
        ),

        child: Column(
          children: [
            SizedBox(
              height: const MyDimensions().spaceHeight,
            ),

            // the white container
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 42),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(48)),
                  ),
                ),

                // the colum of input fields
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _formController,
                        child: Column(
                          children: [
                            // the rest of the input fields

                            // the username and telephone next ot each other
                            Input(
                              width: MediaQuery.of(context).size.width - 30,
                              label: 'Username',
                              controller: _username,
                              password: _username,
                            ),

                            Input(
                              width: MediaQuery.of(context).size.width - 30,
                              label: 'Password',
                              controller: _password,
                              password: _password,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // the sing up button
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: const MyDimensions().bottomButtonHeight),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: login,
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(300, 60),
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            ),
                            child: Text("Log in",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

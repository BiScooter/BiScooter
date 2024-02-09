// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:biscooter/services/connection.dart';
import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/services/user.dart';
import 'package:biscooter/widget/input.dart';

import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formController = GlobalKey<FormState>();
  final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void change() async {
    FocusScope.of(context).unfocus();

      // if the form is valid go and send the login request
      // TODO: activate this when the server is ready
      if (_formController.currentState!.validate()) {
        try {

          // send a login request to the server
          Response response = await post(
            Uri.parse(
                "${const Connection().baseUrl}/users/ChangePassword/${User().getId}"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              // "oldPassword": _oldPassword.text,
              "NeededPassword": _newPassword.text,
            }),
          );


          debugPrint(response.body);
          // check if the login was successful
          if (response.statusCode == 200) {
            // Decode the response body
            Fluttertoast.showToast(
              msg: "Password Changed Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
            );
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
          else if (response.statusCode == 401) {
            Fluttertoast.showToast(
              msg: "Invalid password",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
            );
          } // if the login was not successful
          else {
            Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
            );
          }
        }
         catch (e) {
          debugPrint(e.toString());

          }
        }
      }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Change Password"),
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

                            Input(
                              width: MediaQuery.of(context).size.width - 30,
                              label: 'Old Password',
                              controller: _oldPassword,
                              password: _oldPassword,
                            ),

                            // new password field
                            Input(
                              width: MediaQuery.of(context).size.width - 30,
                              label: 'New Password',
                              controller: _newPassword,
                              password: _newPassword,
                            ),
                            Input(
                              width: MediaQuery.of(context).size.width - 30,
                              label: 'Confirm Password',
                              controller: _confirmPassword,
                              password: _newPassword,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // the button
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: const MyDimensions().bottomButtonHeight),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: change,
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(300, 60),
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            ),
                            child: Text("Change Password",
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

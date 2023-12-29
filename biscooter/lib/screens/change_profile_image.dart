// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/services/connection.dart';
import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/input.dart';
import "package:flutter/material.dart";
// TODO: remove the commenting when the server is ready
import 'dart:convert';
import 'package:biscooter/services/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ChangeProfileImage extends StatefulWidget {
  final Function refresh;
  const ChangeProfileImage({super.key, required this.refresh});

  @override
  State<ChangeProfileImage> createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage> {
  final _formController = GlobalKey<FormState>();
  final _url = TextEditingController();
  double radius = 120;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url.text = User().getProfileImage;
  }

  void change() async {
    FocusScope.of(context).unfocus();

    // if the form is valid go and send the change request
    // TODO: activate this when the server is ready
    if (_formController.currentState!.validate()) {
      try {
        // send a change request to the server
        Response response = await post(
          Uri.parse("${const Connection().baseUrl}/users/changeProfileImage/${User().getId}"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            "img_url": _url.text,
          }),
        );

        // check if the change was successful
        if (response.statusCode == 200) {
          // Decode the response body
          User().setProfileImage = _url.text;
          widget.refresh();
          Fluttertoast.showToast(
            msg: "Changed Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );
        } // invalid email or password
        else if (response.statusCode == 401) {
          Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16,
          );
        } // if the change was not successful
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
      } catch (e) {
        debugPrint(e.toString());
      }

      // TODO: remove this line when the server is ready
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil("/profile", (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Change Profile Image"),
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
            Container(
              height: const MyDimensions().spaceHeight *2.2,
              padding: const EdgeInsets.only(top: 62),
              child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            radius: radius,
                            child: CircleAvatar(
                              radius: radius*0.92,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(_url.text),
                            ),
                          ),
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
                              label: 'Image url',
                              controller: _url,
                              password: _url,
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
                            child: Text("Change",
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

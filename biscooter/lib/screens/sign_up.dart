// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/services/user.dart';
import 'package:biscooter/widget/input.dart';
import "package:flutter/material.dart";
// TODO: remove the commenting when the server is ready
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formController = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _middleName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _telephone = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  void setUserService(int id, String invitationCode, String profileImage) {
    User user = User();
    user.setId = id;
    user.setFName = _firstName.text;
    user.setMName = _middleName.text;
    user.setLName = _lastName.text;
    user.setInvitationCode = invitationCode;
    user.setProfileImage = profileImage;
    user.setBalance = 0;
    user.setRidingTime = 0;
  }

  void sign() async {
    if (_formController.currentState!.validate()) {
      // TODO: activate this when the server is ready
      // try {
      //   Response response = await post(
      //     Uri.parse("http://localhost:3000/signup"),
      //     body: {
      //       "firstName": _firstName.text,
      //       "middleName": _middleName.text,
      //       "lastName": _lastName.text,
      //       "email": _email.text,
      //       "telephone": _telephone.text,
      //       "username": _username.text,
      //       "password": _password.text,
      //     },
      //   );

      //   if (response.statusCode == 200) {
      //     // Decode the response body
      //     Map<String, dynamic> responseData = jsonDecode(response.body);

      //     // Get the data from the response
      //     int id = responseData['id'];
      //     String invitationCode = responseData['invitationCode'];
      //     String profileImage = responseData['profileImage'];

      //     // fill the user service with the data
      //     setUserService(id, invitationCode, profileImage);
      //     User.setLoggedIn();

      //     if (mounted) {
      //       Navigator.pushNamed(context, '/verification',
      //           arguments: {'phoneNumber': _telephone.text});
      //     }
      //   } else {
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

      // TODO: remove those lines when the server is ready
      setUserService(0, "", "");
      Navigator.pushNamed(context, '/verification',
          arguments: {'phoneNumber': '1234567890'});
    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _email.dispose();
    _telephone.dispose();
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Sign up"),
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
                width: double.infinity,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(48)),
                  ),
                ),

                // the colum of input fields
                child: SingleChildScrollView(
                  child: Form(
                    key: _formController,
                    child: Column(
                      children: [
                        // the name input fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Input(
                              width: MediaQuery.of(context).size.width / 3 - 21,
                              label: 'First Name',
                              controller: _firstName,
                              password: _firstName,
                            ),
                            const SizedBox(width: 10),
                            Input(
                              width: MediaQuery.of(context).size.width / 3 - 21,
                              label: 'Middle Name',
                              controller: _middleName,
                              password: _middleName,
                            ),
                            const SizedBox(width: 10),
                            Input(
                              width: MediaQuery.of(context).size.width / 3 - 21,
                              label: 'Last Name',
                              controller: _lastName,
                              password: _lastName,
                            ),
                          ],
                        ),

                        // the rest of the input fields
                        Input(
                          width: MediaQuery.of(context).size.width - 30,
                          label: 'Email',
                          controller: _email,
                          password: _email,
                        ),

                        // the username and telephone next ot each other
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Input(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              label: 'Username',
                              controller: _username,
                              password: _username,
                            ),
                            Input(
                              width: MediaQuery.of(context).size.width / 2 - 20,
                              label: 'Telephone',
                              controller: _telephone,
                              password: _telephone,
                            ),
                          ],
                        ),

                        Input(
                          width: MediaQuery.of(context).size.width - 30,
                          label: 'Password',
                          controller: _password,
                          password: _password,
                        ),
                        Input(
                          width: MediaQuery.of(context).size.width - 30,
                          label: 'Confirm Password',
                          controller: _confirmPassword,
                          password: _password,
                        ),

                        // the sing up button
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0, bottom: 25),
                          child: ElevatedButton(
                            onPressed: sign,
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(300, 60),
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            ),
                            child: Text("Sign up",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

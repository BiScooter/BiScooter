// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/screens/verification.dart';
import 'package:biscooter/widget/input.dart';
import "package:flutter/material.dart";

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

  void sign() {
    if (_formController.currentState!.validate())
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Verification(phoneNumber: _telephone.text),
        ),
      );
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

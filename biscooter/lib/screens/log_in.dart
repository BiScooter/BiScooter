// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/widget/input.dart';
import "package:flutter/material.dart";

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  static const double spaceHeight = 180;

  final _formController = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  void login() {
    _formController.currentState?.validate();
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
            const SizedBox(
              height: spaceHeight,
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
                        padding: const EdgeInsets.only(bottom: 70.0),
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

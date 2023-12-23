// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/screens/profile.dart';
import 'package:biscooter/services/my_dimensions.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class Verification extends StatefulWidget {
  final String phoneNumber;
  const Verification({super.key, required this.phoneNumber});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  void verify() {
    Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const Profile()),
    (Route<dynamic> route) => false,
  );
  }

  void resend() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Verification"),
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
              height: const MyDimensions().spaceHeight + 30,
            ),

            // the white container
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 80),
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
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DigitInput(),
                        DigitInput(),
                        DigitInput(),
                        DigitInput(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Enter the code sent to +2${widget.phoneNumber}.'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Didn\'t receive the code?'),
                        TextButton(
                          onPressed: resend,
                          child: const Text('Resend.', style: TextStyle(fontSize: 16),),
                        ),
                      ],
                    ),

                    // the sing up button
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: const MyDimensions().bottomButtonHeight),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: verify,
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(300, 60),
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            ),
                            child: Text("Verify",
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

class DigitInput extends StatelessWidget {
  const DigitInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 68,
      child: TextField(
        onChanged: (value) {
          FocusScope.of(context).nextFocus();
        },
        style: Theme.of(context).textTheme.labelLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}

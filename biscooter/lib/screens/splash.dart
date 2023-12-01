import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  static const double buttonFontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2AF598),
              Color(0xFF009EFD),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.5,
              1,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(300, 60),
                  ),
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: buttonFontSize, color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size(300, 60),
                ),
              ),
              child: const Text(
                "Log in",
                style: TextStyle(fontSize: buttonFontSize, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 140,
            ),
          ],
        ),
      ),
    );
  }
}

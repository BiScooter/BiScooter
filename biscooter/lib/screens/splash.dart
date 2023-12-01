import 'package:biscooter/screens/sign_up.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  static const double buttonFontSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // use a container to give a gradient background color
        width: MediaQuery.of(context).size.width, // to take all the width of the screen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [
              0.3,
              1,
            ],
          ),
        ),
        child: Column( // a column to stack the buttons
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('imgs/biscooter.png'),
            // the sign up button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()),);
                },
                style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(300, 60),
                  ),
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: buttonFontSize, color: Colors.black),
                ),
              ),
            ),

            // log in button
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size(300, 60),
                ),
                backgroundColor: MaterialStatePropertyAll(Colors.white),
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

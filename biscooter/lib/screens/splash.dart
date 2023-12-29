import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            Image.asset('assets/imgs/biscooter.png'),
            // the sign up button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/sign_up");
                },
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(
                    Size(300, 60),
                  ),
                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
                ),
                child: Text(
                  "Sign up",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),

            // log in button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/log_in");
              },
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(
                  Size(300, 60),
                ),
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
              ),
              child: Text(
                "Log in",
                style: Theme.of(context).textTheme.labelLarge,
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

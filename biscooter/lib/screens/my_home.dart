import 'package:biscooter/screens/pre_profile.dart';
import 'package:biscooter/screens/splash.dart';
import 'package:biscooter/services/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({
    super.key,
  });

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool finishedLoading = false;
  late bool isLoggedIn = false;

  void isLoggedInCheck() async {
    isLoggedIn = await User.isLoggedIn();
    debugPrint("My home checking: ${isLoggedIn.toString()}");
    setState(() {
      finishedLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoggedInCheck();
  }

  @override
  Widget build(BuildContext context) {
    if (finishedLoading) {
      return isLoggedIn ? const PreProfile() : const Splash();
    } else {
      return Scaffold(
        body: Container(
          // use a container to give a gradient background color
          width: MediaQuery.of(context)
              .size
              .width, // to take all the width of the screen
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
          child: Column(
            // a column to stack the buttons
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/imgs/biscooter.png'),
              const SizedBox(
                height: 140,
              ),
            ],
          ),
        ),
      );
    }
  }
}

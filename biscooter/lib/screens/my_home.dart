import 'package:biscooter/screens/pre_profile.dart';
import 'package:biscooter/screens/splash.dart';
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
  SharedPreferences? prefs;
  bool isLoggedIn = false;

  void isLoggedInCheck() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = (prefs!.getBool('isLoggedIn') ?? false);
  }

  @override
  void initState() {
    super.initState();
    isLoggedInCheck();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const PreProfile() : const Splash();
  }
}
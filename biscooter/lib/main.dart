import 'package:flutter/services.dart';
import 'package:biscooter/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biscooter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: const Color(0xFF2AF598),
          secondary:const Color(0xFF009EFD),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}

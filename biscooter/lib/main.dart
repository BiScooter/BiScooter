import 'package:biscooter/screens/recharge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        /// text ("",style :theme.of(context).bodyMedium)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: const Color(0xFFFFB13D),
          secondary: const Color(0xFFFF0000),
          surface: const Color(0xFFFF9500),
          surfaceTint: const Color(0xFFFD5A50),
          primaryContainer: const Color.fromARGB(255, 251, 242, 232), // this is used for buttons background color
          shadow: const Color.fromARGB(255, 250, 154, 102),
        ),

        // appBar data theme
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 42,
            color: Colors.black,
          ),
        ),

        // text styles
        textTheme: const TextTheme(
          bodyLarge: TextStyle(), //for header
          bodyMedium: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 65,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          labelLarge: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),

        useMaterial3: true,
      ),
      home: const Recharge(),
    );
  }
}

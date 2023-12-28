import 'package:biscooter/screens/add_biscooter.dart';
import 'package:biscooter/screens/change_password.dart';
import 'package:biscooter/screens/comp_respond.dart';
import 'package:biscooter/screens/invite_friend.dart';
import 'package:biscooter/screens/log_in.dart';
import 'package:biscooter/screens/my_statistics.dart';
import 'package:biscooter/screens/my_wallet.dart';
import 'package:biscooter/screens/offerbike.dart';
import 'package:biscooter/screens/profile.dart';
import 'package:biscooter/screens/recharge.dart';
import 'package:biscooter/screens/rentalhistory.dart';
import 'package:biscooter/screens/send_complaint.dart';
import 'package:biscooter/screens/sign_up.dart';
import 'package:biscooter/screens/splash.dart';
import 'package:biscooter/screens/station.dart';
import 'package:biscooter/screens/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/my_home.dart';

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
      routes: {
        "/": (context) => const MyHome(),
        "/splash": (context) => const Splash(),
        "/profile": (context) => const Profile(),
        "/station": (context) => const Station(),
        "/my_wallet": (context) => const MyWallet(),
        "/recharge": (context) => const Recharge(),
        "/invite_friend": (context) => const InviteFriend(),
        "/rental_history": (context) => const RentalHistory(),
        "/complaint_respond": (context) => const CompRespond(),
        "/change_password": (context) => const ChangePassword(),
        "/my_statistics": (context) => const MyStatistics(),
        "/my_biscooter": (context) => const OfferBike(),
        "/add_biscooter": (context) => const AddBiscooter(),
        "/add_complaint": (context) => const SendComplaint(),
        "/log_in": (context) => const LogIn(),
        "/sign_up": (context) => const SignUp(),
        "/verification": (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return Verification(email: args['email']);
        },
      },
      initialRoute: "/my_biscooter",
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
          primaryContainer: const Color.fromARGB(
              255, 251, 242, 232), // this is used for buttons background color
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
          bodyMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
    );
  }
}

import 'package:biscooter/screens/change_password.dart';
import 'package:biscooter/screens/comp_respond.dart';
import 'package:biscooter/screens/invite_friend.dart';
import 'package:biscooter/screens/my_wallet.dart';
import 'package:biscooter/screens/profile.dart';
import 'package:biscooter/screens/rentalhistory.dart';
import 'package:biscooter/screens/station.dart';
import 'package:flutter/material.dart';



class AppRouts {

  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Profile());
      case "/station":
        return MaterialPageRoute(builder: (_) => Station());
      case "/my_wallet":
        return MaterialPageRoute(builder: (_) => MyWallet());
      case "/invite_friend":
        return MaterialPageRoute(builder: (_) => InviteFriend());
      case "/rental_history":
        return MaterialPageRoute(builder: (_) => RentalHistory());
      case "/complaint_respond":
        return MaterialPageRoute(builder: (_) => CompRespond());
        case"/change_password":
        return MaterialPageRoute(builder: (_) => ChangePassword());
      default:
        return null;

    }
  }
}

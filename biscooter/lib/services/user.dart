import 'package:shared_preferences/shared_preferences.dart';

class User {
  // Define here the variables that you want to use as dimensions
  int _id;
  String _fName;
  String _mName;
  String _lName;
  String _invitationCode;
  String _profileImage;
  double _balance;
  double _ridingTime;

  static final User _instance = User._internal();
  // passes the instantiation to the _instance object
  factory User() => _instance;
  // this function is used to set the login status to true
  static void setLoggedIn() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserLoggedInBiscooter', true);
  }

  static void clearLoggedIn() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserLoggedInBiscooter', false);
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isUserLoggedInBiscooter');
    return isLoggedIn ?? false;
  }

  static void setUserService(
      int id,
      String firstName,
      String middleName,
      String lastName,
      String invitationCode,
      String profileImage,
      double balance,
      double ridingTime) {
    User user = User();
    user.setId = id;
    user.setFName = firstName;
    user.setMName = middleName;
    user.setLName = lastName;
    user.setInvitationCode = invitationCode;
    user.setProfileImage = profileImage;
    user.setBalance = balance;
    user.setRidingTime = ridingTime;
  }

  //initialize variables in here
  User._internal()
      : _fName = "",
        _mName = "",
        _lName = "",
        _balance = 0.0,
        _ridingTime = 0.0,
        _invitationCode = "",
        _profileImage = "",
        _id = 0;

  // getter for my variable
  int get getId => _id;
  String get getFName => _fName;
  String get getMName => _mName;
  String get getLName => _lName;
  String get getInvitationCode => _invitationCode;
  String get getProfileImage => _profileImage;
  double get getBalance => _balance;
  double get getRidingTime => _ridingTime;

  // setter for my variable
  set setId(int value) {
    _id = value;
  }

  set setFName(String value) {
    _fName = value;
  }

  set setMName(String value) {
    _mName = value;
  }

  set setLName(String value) {
    _lName = value;
  }

  set setInvitationCode(String value) {
    _invitationCode = value;
  }

  set setProfileImage(String value) {
    _profileImage = value;
  }

  set setBalance(double value) {
    _balance = value;
  }

  set setRidingTime(double value) {
    _ridingTime = value;
  }
}

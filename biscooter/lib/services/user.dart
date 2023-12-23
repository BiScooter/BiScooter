class User
{
  // Define here the variables that you want to use as dimensions
  final double _myVariable;
  String fName;
  String mName;
  String lName;
  String invitationCode;
  String profileImage;
  double balance;
  double ridingTime;


  static final User _instance = User._internal();
  // passes the instantiation to the _instance object
  factory User() => _instance;

  //initialize variables in here
  User._internal() :_myVariable = 35.0, fName = "", mName = "", lName = "", balance = 0.0, ridingTime = 0.0, invitationCode = "", profileImage = "";

  // getter for my variable
  double get myVariable => _myVariable;
  String get getFName => fName;
  String get getMName => mName;
  String get getLName => lName;
  String get getInvitationCode => invitationCode;
  String get getProfileImage => profileImage;
  double get getBalance => balance;
  double get getRidingTime => ridingTime;

}
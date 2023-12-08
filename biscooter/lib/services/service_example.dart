class MyService
{
  // Define here the variables that you want to use as dimensions
  final double _myVariable;

  static final MyService _instance = MyService._internal();
  // passes the instantiation to the _instance object
  factory MyService() => _instance;

  //initialize variables in here
  MyService._internal() :_myVariable = 35.0;

  // getter for my variable
  double get myVariable => _myVariable;
}
class MyDimensions
{
  // Define here the variables that you want to use as dimensions
  final double _bottomButtonHeight;
  final double _spaceHeight;

  static final MyDimensions _instance = MyDimensions._internal();
  // passes the instantiation to the _instance object
  factory MyDimensions() => _instance;

  //initialize variables in here
  MyDimensions._internal() :_bottomButtonHeight = 35.0, _spaceHeight = 180.0;

  //short getter for my variable
  double get bottomButtonHeight => _bottomButtonHeight;
  double get spaceHeight => _spaceHeight;
}
class MyDimensions
{
  // Define here the variables that you want to use as dimensions
  double _bottomButtonHeight; 

  static final MyDimensions _instance = MyDimensions._internal();
  // passes the instantiation to the _instance object
  factory MyDimensions() => _instance;

  //initialize variables in here
  MyDimensions._internal() :_bottomButtonHeight = 40.0;

  //short getter for my variable
  double get bottomButtonHeight => _bottomButtonHeight;
}
class Connection
{
  // Define here the variables that you want to use as dimensions
  static const String  _baseUrl = "http://192.168.1.12:8080";

  //initialize variables in here
  const Connection();

  //short getter for my variable
  String get baseUrl => _baseUrl;
}
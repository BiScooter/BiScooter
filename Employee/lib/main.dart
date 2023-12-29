import 'dart:convert';


import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee/connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //List = [1, 2, 3, 4, 5];

  late Future<List<Bike>?> bike_list;
  late Future<List<scooter>?> scooter_list;
  late Future<List<Usernmae_clint>?> name_clint;
  late Future<List<Username_employee>?> name_employee;
  late Future<List<Username_Admin>?> name_admin;
  late Future<List<suppliers>?> name_supplier;
  late Future<List<client>?> clients;

  var selectednameofclint;
  var selectedValuebike;
  var selectedValuescooter;
  var selectedValueClint;
  var selectedValueEmployee;
  var selectedValueAdmin;
  var selectedValueSupplier;
  @override
  void initState() {
    super.initState();

    bike_list = Fetchbike();
    scooter_list = Fetchscooter();
    name_clint = FetchusernameofClint();
    name_employee = FetchusernameofEmployee();
    name_admin = FetchusernameofAdmin();
    name_supplier = Fetchusernameofsupplier();
    clients = FetchClints();
  }

  Future<List<client>?> FetchClints() async {
    try {
      final response =
          await get(Uri.parse("${const Connection().baseUrl}/RetrieveClientsData"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<Bike>?> Fetchbike() async {
    try {
      final response =
          await get(Uri.parse("${const Connection().baseUrl}/AllBikesID"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<scooter>?> Fetchscooter() async {
    try {
      final response =
          await get(Uri.parse("${const Connection().baseUrl}/AllScootersID"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<Usernmae_clint>?> FetchusernameofClint() async {
    try {
      final response = await get(
          Uri.parse("${const Connection().baseUrl}/AllClientsUsername"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<Username_employee>?> FetchusernameofEmployee() async {
    try {
      final response = await get(
          Uri.parse("${const Connection().baseUrl}/AllEmployeeUsername"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<Username_Admin>?> FetchusernameofAdmin() async {
    try {
      final response = await get(
          Uri.parse("${const Connection().baseUrl}/AllAdminUsername"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<suppliers>?> Fetchusernameofsupplier() async {
    try {
      final response = await get(
          Uri.parse("${const Connection().baseUrl}/AllSuppliersUsername"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  void dropbike() async {
    try {
      final response = await post(Uri.parse(
          "${const Connection().baseUrl}/ModularDeletion/${selectedValuebike}/4"));
      if (response.statusCode == 200) {
        // Decode the response body
        Fluttertoast.showToast(
          msg: "bike droped Sucssefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        initState();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dropscooter() async {
    try {
      final response = await post(Uri.parse(
          "${const Connection().baseUrl}/ModularDeletion/${selectedValuescooter}/5"));
      if (response.statusCode == 200) {
        // Decode the response body
        Fluttertoast.showToast(
          msg: "Scooter droped Sucssefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        initState();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dropClint() async {
    try {
      final response = await post(Uri.parse(
          "${const Connection().baseUrl}/ModularDeletion/${selectedValueClint}/3"));
      if (response.statusCode == 200) {
        // Decode the response body
        Fluttertoast.showToast(
          msg: "bike droped Sucssefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        initState();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dropEmployee() async {
    try {
      final response = await post(Uri.parse(
          "${const Connection().baseUrl}/ModularDeletion/${selectedValueEmployee}/2"));
      if (response.statusCode == 200) {
        // Decode the response body
        Fluttertoast.showToast(
          msg: "bike droped Sucssefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        initState();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dropAdmin() async {
    try {
      final response = await post(Uri.parse(
          "${const Connection().baseUrl}/ModularDeletion/${selectedValueAdmin}/1"));
      if (response.statusCode == 200) {
        // Decode the response body
        Fluttertoast.showToast(
          msg: "bike droped Sucssefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        initState();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dropSupplier() async {
    try {
      final response = await post(Uri.parse(
          "${const Connection().baseUrl}/ModularDeletion/${selectedValueSupplier}/6"));
      if (response.statusCode == 200) {
        // Decode the response body
        Fluttertoast.showToast(
          msg: "bike droped Sucssefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
        initState();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /// text ("",style :theme.of(context).bodyMedium)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Color.fromARGB(255, 0, 0, 0),
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
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Drop Bike'),
                    SizedBox(
                      width: 100,
                    ),
                    FutureBuilder<List<Bike>?>(
                      future: bike_list,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Error occurred while fetching the data'),
                            );
                          }
                          final data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return Center(
                              child: Text('No bikes found.'),
                            );
                          } else {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<int>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: data
                                    .map((Bike item) => DropdownMenuItem<int>(
                                          value: item.id,
                                          child: Text(
                                            item.id.toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValuebike,
                                onChanged: (var value) {
                                  setState(() {
                                    selectedValuebike = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    ElevatedButton(onPressed: dropbike, child: Text('drop')),
                  ],
                ),
                Row(
                  children: [
                    Text('Drop Scooter'),
                    SizedBox(
                      width: 100,
                    ),
                    FutureBuilder<List<scooter>?>(
                      future: scooter_list,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Error occurred while fetching the data'),
                            );
                          }
                          final data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return Center(
                              child: Text('No scooter found.'),
                            );
                          } else {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<int>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: data
                                    .map(
                                        (scooter item) => DropdownMenuItem<int>(
                                              value: item.id,
                                              child: Text(
                                                item.id.toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                    .toList(),
                                value: selectedValuescooter,
                                onChanged: (var value) {
                                  setState(() {
                                    selectedValuescooter = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    ElevatedButton(onPressed: dropscooter, child: Text('drop'))
                  ],
                ),
                Row(
                  children: [
                    Text('Drop clint'),
                    SizedBox(
                      width: 100,
                    ),
                    FutureBuilder<List<Usernmae_clint>?>(
                      future: name_clint,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Error occurred while fetching the data'),
                            );
                          }
                          final data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return Center(
                              child: Text('No clint found.'),
                            );
                          } else {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: data
                                    .map((Usernmae_clint item) =>
                                        DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectednameofclint,
                                onChanged: (var value) {
                                  setState(() {
                                    selectednameofclint = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    ElevatedButton(onPressed: dropClint, child: Text('drop'))
                  ],
                ),
                Row(
                  children: [
                    Text('Drop Employee'),
                    SizedBox(
                      width: 100,
                    ),
                    FutureBuilder<List<Username_employee>?>(
                      future: name_employee,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Error occurred while fetching the data'),
                            );
                          }
                          final data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return Center(
                              child: Text('No employee found.'),
                            );
                          } else {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: data
                                    .map((Username_employee item) =>
                                        DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValueEmployee,
                                onChanged: (var value) {
                                  setState(() {
                                    selectedValueEmployee = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    ElevatedButton(onPressed: dropEmployee, child: Text('drop'))
                  ],
                ),
                Row(
                  children: [
                    Text('Drop Admin'),
                    SizedBox(
                      width: 100,
                    ),
                    FutureBuilder<List<Username_employee>?>(
                      future: name_employee,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Error occurred while fetching the data'),
                            );
                          }
                          final data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return Center(
                              child: Text('No admin found.'),
                            );
                          } else {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: data
                                    .map((Username_employee item) =>
                                        DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValueAdmin,
                                onChanged: (var value) {
                                  setState(() {
                                    selectedValueAdmin = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    ElevatedButton(onPressed: dropAdmin, child: Text('drop'))
                  ],
                ),
                Row(
                  children: [
                    Text('Drop suppliers'),
                    SizedBox(
                      width: 100,
                    ),
                    FutureBuilder<List<suppliers>?>(
                      future: name_supplier,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                  'Error occurred while fetching the data'),
                            );
                          }
                          final data = snapshot.data;
                          if (data == null || data.isEmpty) {
                            return Center(
                              child: Text('No suppliers found.'),
                            );
                          } else {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: data
                                    .map((suppliers item) =>
                                        DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValueSupplier,
                                onChanged: (var value) {
                                  setState(() {
                                    selectedValueSupplier = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                    ElevatedButton(onPressed: dropSupplier, child: Text('drop'))
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text('View Station information'),
                        SizedBox(
                          width: 100,
                        ),
                        ElevatedButton(
                            onPressed: dropSupplier,
                            child: Text('Get Clients')),
                      ],
                    ),
                    FutureBuilder<List<client>?>(
                        future: clients,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                    'Error occurred while fetching the data'),
                              );
                            }
                            final data = snapshot.data;
                            if (data == null || data.isEmpty) {
                              return const Center(
                                child: null,
                              );
                            } else {
                              return DataTable(
                                  columns: [
                                    DataColumn(label: Text('FNAME')),
                                    DataColumn(label: Text('MNAME')),
                                    DataColumn(label: Text('LNAME')),
                                    DataColumn(label: Text('EMAIL')),
                                    DataColumn(label: Text('USERNAME')),
                                    DataColumn(label: Text('TELEPHONE')),
                                    DataColumn(label: Text('NVITATION_CODE')),
                                    DataColumn(label: Text('WALLET')),
                                  ],
                                  rows: data.map(
                                    (client item)  {
                                      return DataRow(cells: [
                                        DataCell(
                                          Text('${item.FNAME}')
                                      ),
                                      DataCell(
                                          Text('${item.MNAME}')
                                      ),
                                      DataCell(
                                          Text('${item.LNAME}')
                                      ),
                                      DataCell(
                                          Text('${item.EMAIL}')
                                      ),
                                      DataCell(
                                          Text('${item.USERNAME}')
                                      ),
                                      DataCell(
                                          Text('${item.TELEPHONE}')
                                      ),
                                      DataCell(
                                          Text('${item.NVITATION_CODE}')
                                      ),
                                       DataCell(
                                          Text('${item.WALLET}')
                                      ),

                                      ])
                                      ;
                                    },
                                  )
                                  .toList()
                                  );
                            }
                          }
                        })
                  ],
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}

class scooter {
  final int id;

  scooter({
    required this.id,
  });

  static scooter fromJson(json) => scooter(
        id: json['id'],
      );
}

class Bike {
  final int id;

  Bike({
    required this.id,
  });

  static Bike fromJson(json) => Bike(
        id: json['id'],
      );
}

class Usernmae_clint {
  final String name;

  Usernmae_clint({
    required this.name,
  });

  static Usernmae_clint fromJson(json) => Usernmae_clint(
        name: json['user_name'],
      );
}

class Username_employee {
  final String name;

  Username_employee({
    required this.name,
  });

  static Username_employee fromJson(json) => Username_employee(
        name: json['user_name'],
      );
}

class Username_Admin {
  final String name;

  Username_Admin({
    required this.name,
  });

  static Username_Admin fromJson(json) => Username_Admin(
        name: json['user_name'],
      );
}

class suppliers {
  final String name;

  suppliers({
    required this.name,
  });

  static suppliers fromJson(json) => suppliers(
        name: json['user_name'],
      );
}

class client {
  final String FNAME;
  final String MNAME;
  final String LNAME;
  final String EMAIL;
  final String USERNAME;
  final String TELEPHONE;
  final String NVITATION_CODE;
  final String WALLET;

  client({
    required this.FNAME,
    required this.MNAME,
    required this.LNAME,
    required this.EMAIL,
    required this.USERNAME,
    required this.TELEPHONE,
    required this.NVITATION_CODE,
    required this.WALLET,
  });

  static client fromJson(json) => client(
        FNAME: json['FNAME'],
        LNAME: json['LNAME'],
        MNAME: json['MNAME'],
        EMAIL: json['EMAIL'],
        USERNAME: json['USERNAME'],
        TELEPHONE: json['TELEPHONE'],
        NVITATION_CODE: json['NVITATION_CODE'],
        WALLET: json['WALLET'],
      );
}
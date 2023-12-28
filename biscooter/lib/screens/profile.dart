
import 'dart:convert';

import 'package:biscooter/services/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../widget/drawer.dart';
import '../widget/card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

enum SampleItem { changePassword, uploadPhoto }

late Future<List<cart_station>?> stations;

class _ProfileState extends State<Profile> {
//some data of user i will need
  User user = User();
  String? firstName;
  String? middleName;
  String? lastName;
  String? imageUrl;

  @override
  void initState() {
    firstName = user.getFName;
    middleName = user.getMName;
    lastName = user.getLName;
    imageUrl = user.getProfileImage;

    super.initState();
    stations = FetchStations();
  }

  Object? selectedMenu;
  int index = 0;

  final url = "";

  Future<List<cart_station>?> FetchStations() async {
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Decode the response body
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map<cart_station>(cart_station.fromJson).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  final controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,
        ],
      )),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: const MyDrawer(),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            radius: 64,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(imageUrl!),
                            ),
                          ),
                          Text(
                            '$firstName $middleName $lastName',
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'PlayfairDisplay'),
                          ),
                          const Text('Wanna take a ride today?',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'PlayfairDisplay')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 23.0, 0, 0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate(stations));
                            },
                            icon: const Icon(
                              Icons.search_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          PopupMenuButton(
                            icon: const Icon(Icons.settings),
                            color: Colors.white,
                            initialValue: selectedMenu,
                            // Callback that sets the selected popup menu item.
                            onSelected: (item) {
                              setState(() {});
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SampleItem>>[
                              PopupMenuItem(
                                value: SampleItem.changePassword,
                                child: const Text('Change Password'),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/change_password');
                                },
                              ),
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.uploadPhoto,
                                child: const Text('Upload a new photo '),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: double.infinity,
                    child: Image.asset('assets/imgs/bike.png')),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Stations",
                        style: TextStyle(
                            fontFamily: 'PlayfairDisplay', fontSize: 24),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.animateToPage(index + 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          setState(() {
                            debugPrint(
                                "Profile page, invCode: ${User().getInvitationCode}");
                            index = (index + 1) % 6;
                          });
                        },
                        icon: const Icon(
                          Icons.navigate_next_outlined,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 324,
                  child: FutureBuilder<List<cart_station>?>(
                    future: stations,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else {
                        if (snapshot.hasError) {
                          return const Center(
                            child:
                                Text('Error occurred while fetching the data'),
                          );
                        }
                        final data = snapshot.data;
                        if (data == null || data.isEmpty) {
                          return Center(
                            child: Text('No stations found.'),
                          );
                        } else {
                          return SingleChildScrollView(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: data.map((e) {
                                return MYCard(
                                  
                                    station_name: e.name,
                                    num_bike: e.amount_bike,
                                    num_scooter: e.amount_bike,
                                    id: e.id);
                              }).toList(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final Future<List<cart_station>?> stationlist;

  late Future<List<String>?> matchQuery;

  CustomSearchDelegate(this.stationlist)
      : super(
          searchFieldStyle: const TextStyle(fontSize: 20),
          searchFieldLabel: "station",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).colorScheme.primary,
          )),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ));
  }

  Future<List<String>?> fetchSearchResults(String query) async {
    List<String>? resultList = await stations.then((list) {
      return list?.map((element) => element.name).toList();
    });

    return resultList;
  }

  @override
  Widget buildResults(BuildContext context) {
    matchQuery = fetchSearchResults(query);
    // Perform your search operation

    // Build and return the search results widget
    return FutureBuilder<List<String>?>(
      future: matchQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          //final results = snapshot.data;
          final results = snapshot.data?.where(
              (item) => item.toLowerCase().contains(query.toLowerCase()));

          if (results == null || results.isEmpty) {
            return Center(
              child: Text('No results found.'),
            );
          } else {
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results.first;
                // Build your search result item widget here
                return ListTile(
                  title: Text(item),
                  // Other widget properties
                );
              },
            );
          }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    matchQuery = fetchSearchResults(query);
    // Perform your search operation

    // Build and return the search results widget
    return FutureBuilder<List<String>?>(
      future: matchQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          //final results = snapshot.data;
          final results = snapshot.data?.where(
              (item) => item.toLowerCase().contains(query.toLowerCase()));

          if (results == null || results.isEmpty) {
            return Center(
              child: Text('No results found.'),
            );
          } else {
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results.first;
                // Build your search result item widget here
                return ListTile(
                  title: Text(item),
                  // Other widget properties
                );
              },
            );
          }
        }
      },
    );
  }
}

class cart_station {
  final int id;
  final String name;
  final int amount_bike;
  final int amount_scooter;

  cart_station(
      {required this.name,
      required this.id,
      required this.amount_bike,
      required this.amount_scooter});

  static cart_station fromJson(json) => cart_station(
        id: json['station_id'],
        name: json['station_name'],
        amount_bike: json['bikes_numbers'],
        amount_scooter: json['scooters_numbers'],
      );
}

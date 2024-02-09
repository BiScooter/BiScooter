// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:biscooter/services/connection.dart';
import 'package:biscooter/widget/bike_card.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/scooter_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Station extends StatefulWidget {
  final String stationName;
  final int id;
  const Station({super.key, required this.stationName, required this.id});

  @override
  State<Station> createState() => _StationState();
}

class _StationState extends State<Station> {
  late Future<List<Bikes>?> bikeList;

  late Future<List<Scooter>?> scooterList;
  @override
  void initState() {
    super.initState();
    bikeList = fetchBike();
    scooterList = fetchScooter();
  }


  Future<List<Bikes>?> fetchBike() async {
    try {
      final response = await get(Uri.parse("${const Connection().baseUrl}StationListing/Bikes/${widget.id}"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  String scooterUrl = "";
  Future<List<Scooter>?> fetchScooter() async {
    try {
      final response = await get(Uri.parse("${const Connection().baseUrl}StationListing/Scooters/${widget.id}"));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  final controllerScooter = PageController(initialPage: 1);
  final controllerBike = PageController(initialPage: 1);
  var indexBike = 0;
  var indexScooter = 0;

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
        child: Scaffold(
          appBar: AppBar(
            title:  Text(
              widget.stationName,
              style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 30),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          drawer: const MyDrawer(),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 100),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bikes',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controllerBike.animateToPage(indexBike + 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          setState(() {
                            indexBike = (indexBike + 1) % 6;
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
                SizedBox(
                  height: 380,
                  child: FutureBuilder<List<Bikes>?>(
                    future: bikeList,
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
                          return const Center(
                            child: Text('No bikes found.'),
                          );
                        } else {
                          return SingleChildScrollView(
                            controller: controllerBike,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: data.map((e) {
                                return BikeCard(
                                  id: e.id,
                                  gearNum: e.gearNum,
                                  size: e.size,
                                  wight: e.wight,
                                  type: e.type,
                                  img: e.img,
                                );
                              }).toList(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Scooters',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controllerScooter.animateToPage(indexScooter + 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          setState(() {
                            indexScooter = (indexScooter + 1) % 6;
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
                SizedBox(
                  height: 380,
                  child: FutureBuilder<List<Scooter>?>(
                      future: scooterList,
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
                              child: Text('No scooter found.'),
                            );
                          } else {
                            return SingleChildScrollView(
                              controller: controllerScooter,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: data.map((e) {
                                  return ScooterCard(
                                    id: e.id,
                                    batteryCapacity: e.batteryCapacity,
                                    maxSpeed: e.maxSpeed,
                                    range: e.range,
                                    img: e.img,
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        }
                      }),
                ),
              ]),
            ),
          ),
        ));
  }
}

class Bikes {
  final int id;
  final String type;
  final int gearNum;
  final int wight;
  final String img;
  final int size;

  Bikes({
    required this.id,
    required this.type,
    required this.gearNum,
    required this.wight,
    required this.img,
    required this.size,
  });

  static Bikes fromJson(json) => Bikes(
        id: json['id'],
        type: json['type'],
        gearNum: json['gear_number'],
        wight: json['wight'],
        img: json['imageUrl'],
        size: json['size'],
      );
}

class Scooter {
  final int id;
  final String maxSpeed;
  final int range;
  final int batteryCapacity;
  final String img;

  Scooter({
    required this.id,
    required this.maxSpeed,
    required this.range,
    required this.batteryCapacity,
    required this.img,
  });

  static Scooter fromJson(json) => Scooter(
      id: json['id'],
      maxSpeed: json['max_speed'],
      range: json['range'],
      batteryCapacity: json['battery_capacity'],
      img: json['imageUrl']);
}

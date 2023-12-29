// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:biscooter/widget/bike_card.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/scooter_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Station extends StatefulWidget {
  final String station_name;
  final int id;
  const Station({super.key, required this.station_name, required this.id});

  @override
  State<Station> createState() => _StationState();
}

class _StationState extends State<Station> {
  late Future<List<bikes>?> bike_list;

  late Future<List<scooter>?> scooter_list;
  @override
  void initState() {
    super.initState();
    bike_list = Fetchbike();
    scooter_list = Fetchscooter();
  }

  String Url = "";
  Future<List<bikes>?> Fetchbike() async {
    try {
      final response = await get(Uri.parse(Url));
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
  Future<List<scooter>?> Fetchscooter() async {
    try {
      final response = await get(Uri.parse(scooterUrl));
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

  final controller_scooter = PageController(initialPage: 1);
  final controller_Bike = PageController(initialPage: 1);
  var index_bike = 0;
  var index_scooter = 0;

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
              widget.station_name,
              style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 30),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          drawer: MyDrawer(),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bikes',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller_Bike.animateToPage(index_bike + 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          setState(() {
                            index_bike = (index_bike + 1) % 6;
                          });
                        },
                        icon: Icon(
                          Icons.navigate_next_outlined,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 380,
                  child: FutureBuilder<List<bikes>?>(
                    future: bike_list,
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
                            child: Text('No bikes found.'),
                          );
                        } else {
                          return SingleChildScrollView(
                            controller: controller_Bike,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: data.map((e) {
                                return BikeCard(
                                  id: e.id,
                                  gear_num: e.gear_num,
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scooters',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller_scooter.animateToPage(index_scooter + 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          setState(() {
                            index_scooter = (index_scooter + 1) % 6;
                          });
                        },
                        icon: Icon(
                          Icons.navigate_next_outlined,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 380,
                  child: FutureBuilder<List<scooter>?>(
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
                            return SingleChildScrollView(
                              controller: controller_scooter,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: data.map((e) {
                                  return ScooterCard(
                                    id: e.id,
                                    battery_capacity: e.battery_capacity,
                                    max_speed: e.max_speed,
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

class bikes {
  final int id;
  final String type;
  final int gear_num;
  final int wight;
  final String img;
  final int size;

  bikes({
    required this.id,
    required this.type,
    required this.gear_num,
    required this.wight,
    required this.img,
    required this.size,
  });

  static bikes fromJson(json) => bikes(
        id: json['id'],
        type: json['type'],
        gear_num: json['gear_number'],
        wight: json['wight'],
        img: json['imageUrl'],
        size: json['size'],
      );
}

class scooter {
  final int id;
  final String max_speed;
  final int range;
  final int battery_capacity;
  final String img;

  scooter({
    required this.id,
    required this.max_speed,
    required this.range,
    required this.battery_capacity,
    required this.img,
  });

  static scooter fromJson(json) => scooter(
      id: json['id'],
      max_speed: json['max_speed'],
      range: json['range'],
      battery_capacity: json['battery_capacity'],
      img: json['imageUrl']);
}

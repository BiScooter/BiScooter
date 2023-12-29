import 'dart:convert';

import 'package:biscooter/services/connection.dart';
import 'package:biscooter/services/user.dart';
import 'package:biscooter/widget/renal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../widget/drawer.dart';

class RentalHistory extends StatefulWidget {
  const RentalHistory({super.key});

  @override
  State<RentalHistory> createState() => _RentalHistoryState();
}

class _RentalHistoryState extends State<RentalHistory> {
 
  @override
  void initState() {

    super.initState();
    rentals = fetchStations();
  }

  late Future<List<Rental_HistoryCard>?> rentals;

  Future<List<Rental_HistoryCard>?> fetchStations() async {
    try {
      final response = await get(Uri.parse("${const Connection().baseUrl}/ClientViews1/${User().getId}"));
      if (response.statusCode == 200) {
        // Decode the response body
        debugPrint(response.body);
        Map<String, dynamic> responseData = jsonDecode(response.body);
        final stations = responseData["Stations_Bikesinfo"];
        return stations
            .map<Rental_HistoryCard>(Rental_HistoryCard.fromJson)
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

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
        drawer:const  MyDrawer(),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:const  EdgeInsets.only(top: 40, left: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon:const  Icon(
                        Icons.history,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                   const  Text(
                      "Rental History",
                      style: TextStyle(
                          fontFamily: 'PlayfairDisplay', fontSize: 24),
                    ),
                  ],
                ),
              ),
              Container(
                width: 324,
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<List<Rental_HistoryCard>?>(
                    future: rentals,
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
                            child: Text('No rentals found.'),
                          );
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: data.map((e) {
                                return RentalHistoryCard(
                                  Total_price: e.Total_price,
                                  date: e.date,
                                  DESTINATION_STATION: e.DESTINATION_STATION,
                                  KICK_OFF_STATION: e.KICK_OFF_STATION,
                                );
                              }).toList(),
                            ),
                          );
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Rental_HistoryCard {
  final KICK_OFF_STATION;
  final DESTINATION_STATION;
  final int Total_price;
  final String date;

  Rental_HistoryCard({
    required this.DESTINATION_STATION,
    required this.KICK_OFF_STATION,
    required this.Total_price,
    required this.date,
  });

  static Rental_HistoryCard fromJson(json) {
     DateTime parsedDate = DateTime.parse(json['DATE_OF_RENTAL']);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
      String date = formatter.format(parsedDate).toString();
       return  Rental_HistoryCard( DESTINATION_STATION: json['DESTINATION_STATION'],
        KICK_OFF_STATION: json['KICK_OFF_STATION'],
        Total_price: int.parse(json['COST']),
        date: date,
      );
  }
}

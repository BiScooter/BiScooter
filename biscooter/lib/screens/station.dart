import 'package:biscooter/widget/bike_card.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/scooter_card.dart';
import 'package:flutter/material.dart';

class Station extends StatefulWidget {
  const Station({super.key});

  @override
  State<Station> createState() => _StationState();
}

class _StationState extends State<Station> {
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
            title: const Text(
              "Station Name",
              style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 30),
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
                  child: SingleChildScrollView(
                    controller: controller_Bike,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),
                        BikeCard(),

                      ],
                    ),
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
                  child: SingleChildScrollView(
                    controller: controller_scooter,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                       ScooterCard(),
                       ScooterCard(),
                       ScooterCard(),
                       ScooterCard(),


                       ScooterCard(),
                       ScooterCard(),
                       ScooterCard(),
                       ScooterCard(),
                       ScooterCard(),
                       ScooterCard(),

                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}

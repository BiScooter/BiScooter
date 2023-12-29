import 'dart:convert';

import 'package:biscooter/widget/bottom.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OfferBike extends StatefulWidget {
  const OfferBike({super.key});

  @override
  State<OfferBike> createState() => _OfferBikeState();
}

class _OfferBikeState extends State<OfferBike> {
  String url2 = "";

  ///get if the user have scooter of bike for not

  Future<int> haveBike() async {
    try {
      final response = await get(Uri.parse(url2));
      if (response.statusCode == 200) {
        // Decode the response body
        dynamic responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    myBike = fetchBike();
    stateData = haveBike();
  }

  String url = "";
  late Future<MyBiscooter?> myBike;

  Future<MyBiscooter?> fetchBike() async {
    try {
      final response = await get(Uri.parse(url));
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

  final _pageController = PageController(initialPage: 0);
  Future<int>? stateData; // if there data  =1  if no bike offered make it 0

  void scrollFunction() {
    // ignore: unrelated_type_equality_checks
    if (stateData == 1) {
      _pageController.animateToPage(1,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    // ignore: unrelated_type_equality_checks
    } else if (stateData == 0) {
      _pageController.animateToPage(0,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Your BiScooter",
          style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            // the styling
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surfaceTint,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.03,
                  0.2,
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 180,
                ),
                WhiteCard(top: 10, child: Container()),
              ],
            ),
          ),
          SizedBox(
            height: 324,
            child: FutureBuilder<MyBiscooter?>(
              future: myBike,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error occurred while fetching the data'),
                    );
                  }
                  //final request = snapshot.data!;
else{
                    return PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 96,
                            ),
                            Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 10,
                              shadowColor: Colors.black,
                              color: Colors.white,
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 300),
                                height: 340,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child:
                                          Image.asset('assets/imgs/bike.png'),
                                    ),
                                    data(context, 'Type', snapshot.data!.type),
                                    data(context, 'Size',
                                        snapshot.data!.size.toString()),
                                    data(context, 'Gear number',
                                        snapshot.data!.gearNumber.toString()),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    statistic(
                                        Icons.access_time,
                                        "Duration",
                                        Colors.blue,
                                        snapshot.data!.totalTime.toString()),
                                    statistic(
                                        Icons.numbers_outlined,
                                        'Rentals',
                                        Colors.red,
                                        snapshot.data!.rentalNumber.toString()),
                                    statistic(
                                        Icons.timeline_sharp,
                                        'Distance',
                                        Colors.orange,
                                        snapshot.data!.distance.toString()),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Bottom(() {
                                Navigator.pushNamed(context, '/add_biscooter');
                                debugPrint("hellow");
                              }, 'Drop BiScooter'),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 96,
                            ),
                            Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 10,
                              shadowColor: Colors.black,
                              color: Colors.white,
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 300),
                                height: 340,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child:
                                          Image.asset('assets/imgs/bike.png'),
                                    ),
                                    data(context, 'No ', ' BiScooter'),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.bottomCenter,
                                child: Bottom(() {}, 'Add BiScooter')),
                          ],
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container statistic(IconData ic, String title, Color co, String data) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 157, 157, 157), //New
              blurRadius: 7.0,
              offset: Offset(2, 3)),
        ],
      ),
      width: 340,
      height: 116,
      child: Row(
        children: [
          Icon(
            ic,
            color: co,
            size: 45,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              const Text(
                'Rentals',
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  Text(
                    data,
                    style: const TextStyle(fontSize: 26),
                  ),
                  const Text(
                    ' times',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row data(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$title :',
          style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
        ),
        Text(
          value,
          style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }
}

class MyBiscooter {
  final String type;
  final int size;
  final String image;
  final int gearNumber;
  final int rentalNumber;
  final int distance;
  final int totalTime;

  MyBiscooter({
    required this.image,
    required this.gearNumber,
    required this.type,
    required this.rentalNumber,
    required this.distance,
    required this.size,
    required this.totalTime,
  });

  static MyBiscooter fromJson(json) => MyBiscooter(
      type: json['Type'],
      size: json['Size'],
      gearNumber: json['Gear_number'],
      rentalNumber: json['Rental_Number'],
      distance: json['Distance'],
      totalTime: json['total_time'],
      image: json['image']);
}

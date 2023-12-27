import 'package:biscooter/widget/bottom.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';

class OfferBike extends StatefulWidget {
  const OfferBike({super.key});

  @override
  State<OfferBike> createState() => _OfferBikeState();
}

class _OfferBikeState extends State<OfferBike> {
  final _pageController = PageController(initialPage: 0);
  var stateData = 0; // if there data  =1  if no bike offered make it 0

  void scrollFunction() {
    if (stateData == 1) {
      _pageController.animateToPage(1,
          duration: const Duration(seconds: 0), curve: Curves.easeInOut);
    } else if (stateData == 0) {
      _pageController.animateToPage(0,
          duration: const Duration(seconds: 0), curve: Curves.easeInOut);
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
          PageView(
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
                      constraints: const BoxConstraints(maxWidth: 300),
                      height: 340,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.asset('assets/imgs/bike.png'),
                          ),
                          data(context, 'Type', 'blablalba'),
                          data(context, 'Size', 'blablalba'),
                          data(context, 'Gear number', 'blablalba'),
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
                          Container(
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(
                                        255, 157, 157, 157), //New
                                    blurRadius: 7.0,
                                    offset: Offset(2, 3))
                              ],
                            ),
                            width: 340,
                            height: 116,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Duration',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '28 ',
                                          style: TextStyle(fontSize: 26),
                                        ),
                                        Text(
                                          ' mins',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(
                                        255, 157, 157, 157), //New
                                    blurRadius: 7.0,
                                    offset: Offset(2, 3)),
                              ],
                            ),
                            width: 340,
                            height: 116,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.numbers_outlined,
                                  color: Colors.red,
                                  size: 45,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Rentals',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '34 ',
                                          style: TextStyle(fontSize: 26),
                                        ),
                                        Text(
                                          ' times',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(
                                        255, 157, 157, 157), //New
                                    blurRadius: 7.0,
                                    offset: Offset(2, 3)),
                              ],
                            ),
                            width: 340,
                            height: 116,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.timeline_sharp,
                                  color: Colors.orange,
                                  size: 45,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Distance',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '34 ',
                                          style: TextStyle(fontSize: 26),
                                        ),
                                        Text(
                                          ' m',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                      constraints: const BoxConstraints(maxWidth: 300),
                      height: 340,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.asset('assets/imgs/bike.png'),
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

class My_Bisscooter {
  final String type;
  final int size;
  final String image;
  final int gearNumber;
  final int rentalNumber;
  final int distance;
  final int totalTime;

  My_Bisscooter({
    required this.image,
    required this.gearNumber,
    required this.type,
    required this.rentalNumber,
    required this.distance,
    required this.size,
    required this.totalTime,
  });

  static My_Bisscooter fromJson(json) => My_Bisscooter(
        type: json['Type'],
        size: json['Size'],
        gearNumber: json['Gear_number'],
        rentalNumber: json['Rental_Number'],
        distance: json['Distance'],
        totalTime: json['total_time'],
        image: json['image']
      );
}

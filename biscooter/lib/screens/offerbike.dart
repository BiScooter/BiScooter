import 'package:biscooter/widget/bottom.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/rentbike.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';

class OfferBike extends StatefulWidget {
  const OfferBike({super.key});

  @override
  State<OfferBike> createState() => _OfferBikeState();
}

class _OfferBikeState extends State<OfferBike> {
  final _PageController = PageController(initialPage: 0);
  var StateData = 0; // if there data  =1  if no bike offered make it 0

  void ScroollFunction() {
    if (StateData == 1) {
      _PageController.animateToPage(1,
          duration: Duration(seconds: 0), curve: Curves.easeInOut);
    }
    if (StateData == 0) {
      _PageController.animateToPage(0,
          duration: Duration(seconds: 0), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
                SizedBox(
                  height: 180,
                ),
                WhiteCard(child: Container(), top: 10),
              ],
            ),
          ),
          PageView(
            controller: _PageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 96,
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    shadowColor: Colors.black,
                    color: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300),
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        255, 157, 157, 157), //New
                                    blurRadius: 7.0,
                                    offset: Offset(2, 3))
                              ],
                            ),
                            width: 340,
                            height: 116,
                            child: Row(
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
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        255, 157, 157, 157), //New
                                    blurRadius: 7.0,
                                    offset: Offset(2, 3)),
                              ],
                            ),
                            width: 340,
                            height: 116,
                            child: Row(
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
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        255, 157, 157, 157), //New
                                    blurRadius: 7.0,
                                    offset: Offset(2, 3)),
                              ],
                            ),
                            width: 340,
                            height: 116,
                            child: Row(
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
                      print("hellow");
                    }, 'Drop BiScooter'),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 96,
                  ),
                  Card(
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    shadowColor: Colors.black,
                    color: Colors.white,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300),
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
          '${title} :',
          style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
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

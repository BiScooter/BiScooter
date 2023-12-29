import 'package:biscooter/widget/bottom.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/rentbike.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RentBike extends StatefulWidget {
  final int state;
  final int id;
  const RentBike({super.key, required this.state, required this.id});

  @override
  State<RentBike> createState() => _RentBikeState();
}

class _RentBikeState extends State<RentBike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Rent a Bike",
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
                WhiteCard(top: 10, child: Container())
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 40,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const RentBikeCard(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        // TextButton(
                        //   child: Text('pick a day'),
                        //   onPressed: () {
                        //     showDialog<Widget>(
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return SfDateRangePicker(
                        //             showActionButtons: true,
                        //             onSubmit: (value) {
                        //               Navigator.pop(context);
                        //             },
                        //             onCancel: () {
                        //               Navigator.pop(context);
                        //             },
                        //           );
                        //         });
                        //   },
                        // ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Bottom(() {}, 'RENT NOW')),
        ],
      ),
    );
  }
}

import 'package:biscooter/widget/bike_card.dart';
import 'package:biscooter/widget/bottom.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/input.dart';
import 'package:biscooter/widget/rentbike.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RentBike extends StatefulWidget {
  const RentBike({super.key});

  @override
  State<RentBike> createState() => _RentBikeState();
}

class _RentBikeState extends State<RentBike> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
                SizedBox(
                  height: 180,
                ),
                WhiteCard(child: Container(), top: 10)
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 40,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RentBikeCard(),

              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
TextButton(
          child: Text('pick a day'),
          onPressed: () {
            showDialog<Widget>(
                context: context,
                builder: (BuildContext context) {
                  return SfDateRangePicker(
                    showActionButtons: true,
                    onSubmit: ( value) {
                      Navigator.pop(context);
                    },
                    onCancel: () {
                     Navigator.pop(context);
                    },
                  );
                });
          },
        ),


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

import 'package:flutter/material.dart';

class MYCard extends StatefulWidget {
  final int id;
  final String station_name;
  final int num_bike;
  final int num_scooter;

  const MYCard(
      {super.key,
      required this.station_name,
      required this.num_bike,
      required this.num_scooter, required this.id});

  @override
  State<MYCard> createState() => _MYCardState();
}

class _MYCardState extends State<MYCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
Navigator.pushNamed(context, '/station',arguments: {
    'stationName': widget.station_name,
    'id': widget.id,
  },);
      },
      child: Card(
        margin: EdgeInsets.all(10),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          width: 322,
          height: 324,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 100,
                    width: 200,
                    child: Image.asset('assets/imgs/S.png')),
                Text(
                  widget.station_name,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'PlayfairDisplay',
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_bike_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Available bikes : ',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'PlayfairDisplay'),
                            ),
                            Text(
                              widget.num_bike.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'KaushanScript',
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.electric_scooter_rounded,
                            color: Theme.of(context).colorScheme.secondary),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Available Scooter : ',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'PlayfairDisplay'),
                            ),
                            Text(
                              widget.num_scooter.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'KaushanScript',
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

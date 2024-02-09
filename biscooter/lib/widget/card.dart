import 'package:flutter/material.dart';

class MYCard extends StatefulWidget {
  final int id;
  final String stationName;
  final int numBike;
  final int numScooter;

  const MYCard(
      {super.key,
      required this.stationName,
      required this.numBike,
      required this.numScooter, required this.id});

  @override
  State<MYCard> createState() => _MYCardState();
}

class _MYCardState extends State<MYCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
Navigator.pushNamed(context, '/station',arguments: {
    'stationName': widget.stationName,
    'id': widget.id,
  },);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 322,
          height: 324,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    height: 100,
                    width: 200,
                    child: Image.asset('assets/imgs/S.png')),
                Text(
                  widget.stationName,
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
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Available bikes : ',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'PlayfairDisplay'),
                            ),
                            Text(
                              widget.numBike.toString(),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.electric_scooter_rounded,
                            color: Theme.of(context).colorScheme.secondary),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Available Scooter : ',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'PlayfairDisplay'),
                            ),
                            Text(
                              widget.numScooter.toString(),
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

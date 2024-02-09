import 'package:flutter/material.dart';

class ScooterCard extends StatefulWidget {
  final int id;
  final String maxSpeed;
  final int range;
  final int batteryCapacity;
  final String img;
  const ScooterCard(
      {super.key,
      required this.id,
      required this.maxSpeed,
      required this.range,
      required this.batteryCapacity,
      required this.img});

  @override
  State<ScooterCard> createState() => _ScooterCardState();
}

class _ScooterCardState extends State<ScooterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 240),
        height: 380,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              child: Image.network(widget.img),
            ),
            rowData(context, 'Max Speed : ', widget.maxSpeed),
            rowData(context, 'Range : ', widget.range.toString()),
            rowData(context, 'Battery Capacity : ',
                widget.batteryCapacity.toString()),
            Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary
                    ],
                  )),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/rent',
                    arguments: {
                      'state': 1,
                      'id': widget.id,
                    },
                  );
                },
                child: const Text(
                  'RENT NOW',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row rowData(BuildContext context, String title, String data) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
        ),
        Text(
          data,
          style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }
}

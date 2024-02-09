import 'package:flutter/material.dart';

class BikeCard extends StatefulWidget {
  final int id;
  final String type;
  final int gearNum;
  final int wight;
  final String img;
  final int size;
  const BikeCard({
    super.key,
    required this.id,
    required this.type,
    required this.gearNum,
    required this.wight,
    required this.img,
    required this.size,
  });

  @override
  State<BikeCard> createState() => _BikeCardState();
}

class _BikeCardState extends State<BikeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        height: 380,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              child: Image.network(widget.img),
            ),
            rowData(context, 'Type : ', widget.type),
            rowData(context, 'Gear Num : ', widget.gearNum.toString()),
            rowData(context, 'size : ', widget.size.toString()),
            rowData(context, 'wight : ', widget.wight.toString()),
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
                      'state': 0,
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
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

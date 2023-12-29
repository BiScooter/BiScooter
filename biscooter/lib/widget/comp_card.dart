import 'package:flutter/material.dart';

class CompCard extends StatefulWidget {
  final String description;
  final String date;
  const CompCard(
      {super.key,
      required this.description,
      required this.date});

  @override
  State<CompCard> createState() => _CompCardState();
}

class _CompCardState extends State<CompCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Icon(Icons.mail),
                Text(
                  widget.date.toString(),
                  style: const TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 16,
                      color: Colors.grey),
                )
              ],
            ),
            const Divider(),
            SizedBox(
              width: double.maxFinite,
              child: Text(widget.description,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

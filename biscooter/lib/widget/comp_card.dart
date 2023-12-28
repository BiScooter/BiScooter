import 'package:flutter/material.dart';

class CompCard extends StatefulWidget {
  final String description;
  final String employeename;
  final DateTime date;
  const CompCard(
      {super.key,
      required this.description,
      required this.employeename,
      required this.date});

  @override
  State<CompCard> createState() => _CompCardState();
}

class _CompCardState extends State<CompCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Container(
        width: 310,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Icon(Icons.mail),
                Text(
                  widget.date.toString(),
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 16,
                      color: Colors.grey),
                )
              ],
            ),
            Divider(),
            Container(
              width: double.maxFinite,
              child: Text('${widget.description} ..... by ${widget.employeename}',
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

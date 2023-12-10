import 'package:flutter/material.dart';

class ScooterCard extends StatefulWidget {
  const ScooterCard({super.key});

  @override
  State<ScooterCard> createState() => _ScooterCardState();
}

class _ScooterCardState extends State<ScooterCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,

      child: Container(
        constraints: BoxConstraints(maxWidth: 240),
        height: 380,


        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset('assets/imgs/i3.png'),
            ),
            Row(
              children: [
                Text(
                  'Max Speed : ',
                  style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
                ),
                Text(
                  '30 m/h  ',
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Range : ',
                  style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
                ),
                Text(
                  '30 m ',
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Battery Capacity : ',
                  style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
                ),
                Text(
                  '30 m ',
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            Container(
                  width: 180,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      gradient:  LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Theme.of(context).colorScheme.primary,Theme.of(context).colorScheme.secondary],
                      )),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent

                          ),
                      onPressed: () {},
                      child: Text(
                        'RENT NOW',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),),
                ),],),
      ),);
  }
}

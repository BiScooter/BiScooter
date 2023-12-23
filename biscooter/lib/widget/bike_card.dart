import 'package:flutter/material.dart';

class BikeCard extends StatefulWidget {
  const BikeCard({super.key});

  @override
  State<BikeCard> createState() => _BikeCardState();
}

class _BikeCardState extends State<BikeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,

      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        height: 380,

        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset('assets/imgs/bike.png'),
            ),
            Row(
              children: [
                Text(
                  'Type : ',
                  style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
                ),
                Text(
                  'blabla  ',
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
                  'Gear Num : ',
                  style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
                ),
                Text(
                  '2',
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
                  'wight : ',
                  style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
                ),
                Text(
                  '30 km ',
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
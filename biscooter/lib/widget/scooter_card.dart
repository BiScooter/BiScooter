import 'package:biscooter/screens/rentbike.dart';
import 'package:flutter/material.dart';

class ScooterCard extends StatefulWidget {
   final int id;
  final String max_speed;
  final int range;
  final int battery_capacity;
  final String img;
  const ScooterCard({super.key, required this.id, required this.max_speed, required this.range, required this.battery_capacity, required this.img});

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
              child:Image.network(widget.img),
            ),
            rowdata(context,'Max Speed : ',widget.max_speed),
            rowdata(context,'Range : ',widget.range.toString()),
            rowdata(context,'Battery Capacity : ',widget.battery_capacity.toString()),


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
                      onPressed: () {
                       Navigator.pushNamed(context, '/rent',arguments: {
    'state': 1,
    'id': widget.id,
  },);
                      },
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

  Row rowdata(BuildContext context,String title,String data) {
    return Row(
            children: [
              Text(
                title,
                style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
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

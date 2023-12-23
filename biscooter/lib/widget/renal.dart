import 'package:flutter/material.dart';
import '../widget/drawer.dart';

class RentalHistoryCard extends StatefulWidget {
  const RentalHistoryCard({super.key});

  @override
  State<RentalHistoryCard> createState() => _RentalHistoryCardState();
}

class _RentalHistoryCardState extends State<RentalHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        height: 340,
        child:
            Column(

               children: [
          Container(
              height: 90,
              width: 160,
              child: Image.asset('assets/imgs/bike.png')),
              SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(

                children: [
                  Text('KICK OFF STATION :',
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'PlayfairDisplay')),
                  Text(
                    'October ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PlayfairDisplay',
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
SizedBox(height: 10,),
              Row(
                children: [
                  Text('DISTINATION STATION :',
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'PlayfairDisplay')),
                  Text(
                    'October ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PlayfairDisplay',
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),

SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                          Text(
                    'Day : ',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PlayfairDisplay',
                        ),

                  ),
                  Text(
                    'sunday ',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PlayfairDisplay',
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                   Text('Date : ',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'PlayfairDisplay')
                          ),
                          Text(
                    '1/2/2023  ',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PlayfairDisplay',
                        color: Theme.of(context).colorScheme.secondary),
                  ),


                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('Total Price :',
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'PlayfairDisplay')),
                  Text(
                    '20 \$ ',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PlayfairDisplay',
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),

SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Distance ',style: TextStyle(fontSize: 16,
                            fontFamily: 'PlayfairDisplay',),),
                            Text('30 m',style: TextStyle(fontSize: 16,
                            fontFamily: 'PlayfairDisplay',)),
                  ],
                ),
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27.5),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,],
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

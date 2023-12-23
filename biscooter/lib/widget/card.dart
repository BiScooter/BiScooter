import 'package:flutter/material.dart';

class MYCard extends StatefulWidget {
  const MYCard({super.key});

  @override
  State<MYCard> createState() => _MYCardState();
}

class _MYCardState extends State<MYCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
                    margin: EdgeInsets.all(10),


                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding:EdgeInsets.all(20)
                      ,
                      width: 322,
                      height: 324,
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [

                        Container(
                            height: 100,
                            width: 200,
                            child: Image.asset('assets/imgs/S.png')),
                             Text(
                          ' October City ',
                          style: TextStyle(
                              fontSize: 30, fontFamily: 'PlayfairDisplay',color:
                               Theme.of(context).colorScheme.secondary ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.directions_bike_outlined,color:Theme.of(context).colorScheme.secondary,),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Available bikes : ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'PlayfairDisplay'),
                                    ),
                                    Text(
                                      '20',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'KaushanScript',color:
                                          Theme.of(context).colorScheme.secondary,),
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
                                Icon(Icons.electric_scooter_rounded,color:Theme.of(context).colorScheme.secondary),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Available Scooter : ',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'PlayfairDisplay'),
                                    ),
                                    Text(
                                      '20',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          fontFamily: 'KaushanScript',color:Theme.of(context).colorScheme.secondary),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ]),
                    ),
                  );

  }
}

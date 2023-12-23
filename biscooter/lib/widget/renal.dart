import 'package:flutter/material.dart';

class RentalHistoryCard extends StatefulWidget {
  const RentalHistoryCard({super.key});

  @override
  State<RentalHistoryCard> createState() => _RentalHistoryCardState();
}

class _RentalHistoryCardState extends State<RentalHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        height: 340,
        child: Column(children: [
          SizedBox(
              height: 90,
              width: 160,
              child: Image.asset('assets/imgs/bike.png')),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('KICK OFF STATION :',
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
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('DESTINATION STATION :',
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
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
                  const Text('Date : ',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'PlayfairDisplay')),
                  Text(
                    '1/2/2023  ',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'PlayfairDisplay',
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('Total Price :',
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
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(27.5),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Distance ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    Text('30 m',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'PlayfairDisplay',
                        )),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

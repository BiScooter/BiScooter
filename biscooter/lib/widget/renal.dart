import 'package:flutter/material.dart';

class RentalHistoryCard extends StatefulWidget {
  final String kickoffStation;
  final String destinationStation;
  final int totalPrice;
  final String date;
  const RentalHistoryCard(
      {super.key,
      required this.kickoffStation,
      required this.destinationStation,
      required this.totalPrice,
      required this.date});

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
          // SizedBox(
          //     height: 90,
          //     width: 160,
          //     child: Image.asset('assets/imgs/bike.png')),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowData(context, 'KICK OFF STATION :', widget.kickoffStation),
              const SizedBox(
                height: 10,
              ),
              rowData(
                  context, 'DESTINATION STATION :', widget.destinationStation),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Date : ',
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'PlayfairDisplay')),
                  Text(
                    widget.date.toString(),
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
              rowData(context, 'Total Price : ', widget.totalPrice.toString()),
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

  Row rowData(BuildContext context, String title, String data) {
    return Row(
      children: [
        Text(title,
            style:
                const TextStyle(fontSize: 16, fontFamily: 'PlayfairDisplay')),
        Text(
          data,
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'PlayfairDisplay',
              color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }
}

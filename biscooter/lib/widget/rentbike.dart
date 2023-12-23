import 'package:flutter/material.dart';

class RentBikeCard extends StatefulWidget {
  const RentBikeCard({super.key});

  @override
  State<RentBikeCard> createState() => _RentBikeCardState();
}

class _RentBikeCardState extends State<RentBikeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        elevation: 10,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Container(
            constraints: BoxConstraints(maxWidth: 300),
            height: 340,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/imgs/bike.png'),
                  ),
                  data(context, 'Type', 'blablalba'),
                   data(context, 'Size', 'blablalba'),
                    data(context, 'Gear number', 'blablalba'),
                    data(context, 'Price', 'blablalba'),
                ])));
  }

  Row data(BuildContext context, String title, String value) {
    return Row(
      children: [
        Text(
          '${title} :',
          style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 20),
        ),
        Text(
          value,
          style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }
}

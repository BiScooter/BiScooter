// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/shadow_card.dart';
import 'package:flutter/material.dart';

class ChoseView extends StatefulWidget {
  const ChoseView({
    super.key,
    required this.height,
    required this.width,
    required this.type,
    required this.choose, required this.controller,
  });

  final double height;
  final double width;
  final String type;
  final Function choose;
  final PageController controller;

  @override
  State<ChoseView> createState() => _ChoseViewState();
}

class _ChoseViewState extends State<ChoseView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Chose your Biscooter type',
            style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 12),
        BiscooterCard(
          height: widget.height,
          width: widget.width,
          type: 'bike',
          image: 'assets/imgs/bike.png',
          padding: 28,
          onPress: widget.choose,
          chosenType: widget.type,
        ),
        const SizedBox(height: 15),
        BiscooterCard(
          height: widget.height,
          width: widget.width,
          type: 'scooter',
          image: 'assets/imgs/MiScooter.png',
          padding: 0,
          onPress: widget.choose,
          chosenType: widget.type,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: const MyDimensions().bottomButtonHeight),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  ),
                  TextButton(onPressed: () {
                    if(widget.type != "") widget.controller.animateToPage(1, duration: const Duration(milliseconds: 50), curve: Curves.easeIn);
                  }, child: const Text('Continue'))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class BiscooterCard extends StatefulWidget {
  const BiscooterCard({
    super.key,
    required this.height,
    required this.width,
    required this.type,
    required this.image,
    required this.padding,
    required this.onPress,
    required this.chosenType,
  });

  final double height;
  final double width;
  final String type;
  final String image;
  final double padding;
  final Function onPress;
  final String chosenType;

  @override
  State<BiscooterCard> createState() => _BiscooterCardState();
}

class _BiscooterCardState extends State<BiscooterCard> {
  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      radius: 16,
      filter: 10,
      child: GestureDetector(
        onTap: () => widget.onPress(widget.type),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: (widget.type == widget.chosenType)
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent, // Color of the border
              width: 2, // Width of the border
            ),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(widget.padding),
          height: widget.height,
          width: widget.width,
          child: Image.asset(widget.image),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  final String title;
  final Function f;

  const Bottom( this.f,this.title,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 70,
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
          onPressed: () {f();},
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  final String title;
  final Function f;

  const Bottom({super.key, required this.title, required this.f});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xfff74f4f), Color(0xfff9af4b)],
          )),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent

              ),
          onPressed: () => f,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )),
    );
  }
}

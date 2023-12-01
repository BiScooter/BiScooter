import 'package:flutter/material.dart';

class bottom extends StatelessWidget {
  final String title;
  const bottom(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        
        onTap: () {
          /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
                      );*/
        },
        child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 350,
            height: 70,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(
                        255, 170, 169, 169), // Specify the color of the shadow
                    offset: Offset(1, 10),
                    blurRadius: 10, // Specify the blur radius of the shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(35),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.surfaceTint
                  ],
                )),
            child: Text(title,
                style: const TextStyle(
                  fontSize: 24,
                ))));
  }
}

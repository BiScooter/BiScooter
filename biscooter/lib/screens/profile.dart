import 'package:biscooter/widget/bottom.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(children: [
          Container(

            alignment: Alignment.center,
            height: 300,
            width: 300,
            decoration:  BoxDecoration(
              boxShadow: [
      BoxShadow(
        color:Color.fromARGB(255, 155, 154, 154), // Specify the color of the shadow

        blurRadius:1000, // Specify the blur radius of the shadow

      ),],
              borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
            child: CircleAvatar(
              minRadius: 80,
              maxRadius: 100,
              backgroundImage:   AssetImage(('assets/imgs/Scooter.png'),

              )
          )),
          Text("Name", style: Theme.of(context).textTheme.bodyMedium),

        Container(margin: EdgeInsets.symmetric(vertical: 30),
          child: Column(
          children: [
            const bottom("Rental History"),
            SizedBox(height: 20,),
            const bottom("Transaction History"),
              SizedBox(height: 20,),
          const bottom("Change Password"),
          ],
        )),

        ]),
      ),
    );
  }
}


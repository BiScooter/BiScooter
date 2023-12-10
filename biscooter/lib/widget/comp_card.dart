import 'package:flutter/material.dart';

class CompCard extends StatefulWidget {
  const CompCard({super.key});

  @override
  State<CompCard> createState() => _CompCardState();
}

class _CompCardState extends State<CompCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      child: Container(
        width: 310,

        padding: EdgeInsets.all(10),
        child: Column(

         children: [
                Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Icon(Icons.mail),
           Text('20 Agu 2019',style: TextStyle(fontFamily: 'PlayfairDisplay',fontSize: 16,color: Colors.grey),)
         ],
                ),
                Divider(),
                Container(
         width: double.maxFinite,
                 child:
                Text('Fusce vehicula dolor arcu, sit ame blandit dolor mollis nec. Done viverra Fusce vehicula dolor arcu, sit ame blandit dolor mollis nec. Done viverra',style: TextStyle(fontFamily: 'PlayfairDisplay',fontSize: 16,)),

               ),

         ],),

      ),
    );
  }
}

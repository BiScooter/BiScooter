import 'package:biscooter/widget/renal.dart';
import 'package:flutter/material.dart';
import '../widget/drawer.dart';

class RentalHistory extends StatefulWidget {
  const RentalHistory({super.key});

  @override
  State<RentalHistory> createState() => _RentalHistoryState();
}

class _RentalHistoryState extends State<RentalHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,
        ],

      )),
      child: Scaffold(

        drawer: MyDrawer(),
         backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(

            children: [
              Container(

                margin: EdgeInsets.only(top:40,left:10),
                child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon:Icon( Icons.history,
                            size: 35,color: Colors.black,),
                          ),
                          Text(
                            "Rental History",
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay', fontSize: 24),
                          ),
                        ],
                      ),
              ),

              Container(
                width: 324,
                height:MediaQuery.of(context).size.height,
                  child: ListView.builder(

                    scrollDirection: Axis.vertical,
                    itemCount:20,

                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {

                        },
                        child: RentalHistoryCard(),
                      );
                    },
                  )

                ),
            ],

          ),
        ),
      ),

    );
  }
}
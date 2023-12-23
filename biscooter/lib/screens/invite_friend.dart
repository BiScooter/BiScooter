import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Invite Friend",
          style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        Container(
          // the styling
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surfaceTint,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
                0.03,
                0.2,
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              WhiteCard(child: Container(), top: 10)
            ],
          ),
        ),
        Positioned(
          top: 100,
          left: 40,
          child: Card(
            elevation: 30,
            shadowColor: Colors.black,
            color: Color.fromARGB(255, 255, 238, 213) ,         shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              width: 300,
              height: 470,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                        width: 300,
                        height: 300,
                        child: Image.asset('assets/imgs/i1.png')),
                  ),
                  Positioned(
                    top: 320,
                    left: 0,
                    child: Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: Column(children: [
                        Text(
                          'Your Invitation Code',
                          style: TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                              color: Colors.grey[800]),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.center,
                          width: 230,
                          height: 67,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'KD08CS2006',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

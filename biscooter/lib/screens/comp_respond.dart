import 'package:biscooter/widget/bottom.dart';
import 'package:biscooter/widget/comp_card.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';

class CompRespond extends StatefulWidget {
  const CompRespond({super.key});

  @override
  State<CompRespond> createState() => _CompRespondState();
}

class _CompRespondState extends State<CompRespond> {
  void goToSendComplaint() {
    Navigator.pushNamed(context, '/add_complaint');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Complaints Respond",
          style: TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 30),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
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
                const SizedBox(
                  height: 180,
                ),
                WhiteCard(top: 10, child: Container()),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100),
            width: double.infinity,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.77,
            child: const SingleChildScrollView(
              child: Column(children: [
                CompCard(),
                CompCard(),
                CompCard(),
                CompCard(),
                CompCard(),
                CompCard(),
                CompCard(),
              ]),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Bottom(goToSendComplaint, "Add Complaints")),
        ],
      ),
    );
  } 
}

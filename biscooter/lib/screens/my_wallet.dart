// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/shadow_card.dart';
import "package:flutter/material.dart";
import 'package:biscooter/widget/white_card.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});
  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  final double _balanceCardWidth = 320;
  final double _balanceCardHeight = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("My Wallet"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // the body of the page
      body: Container(
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
              0.08,
              0.25,
            ],
          ),
        ),

        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: const MyDimensions().spaceHeight + 90,
                ),
                // the white card container
                const WhiteCard(
                  top: 0,
                  child: WhiteCardContent(),
                ),
              ],
            ),
            BalanceCard(
              balanceCardWidth: _balanceCardWidth,
              balanceCardHeight: _balanceCardHeight,
              child: const Text('data')
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final Widget child;
  const BalanceCard({
    super.key,
    required double balanceCardWidth,
    required double balanceCardHeight, required this.child,
  })  : _balanceCardWidth = balanceCardWidth,
        _balanceCardHeight = balanceCardHeight;

  final double _balanceCardWidth;
  final double _balanceCardHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: const MyDimensions().spaceHeight,
      left: (MediaQuery.of(context).size.width - _balanceCardWidth) / 2,
      child: ShadowCard(
        radius: 16,
        filter: 10,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/imgs/pattern.jpeg'),
                fit: BoxFit.cover),
          ),
          height: _balanceCardHeight,
          width: _balanceCardWidth,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 255, 255, 255),
                  Color.fromARGB(173, 255, 255, 255),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class WhiteCardContent extends StatelessWidget {
  const WhiteCardContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('data'),
        // The bottom button
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: const MyDimensions().bottomButtonHeight),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(
                    Size(300, 60),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer),
                ),
                child: Text("Balance Recharge",
                    style: Theme.of(context).textTheme.labelLarge),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

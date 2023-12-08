// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/shadow_card.dart';
import 'package:biscooter/widget/white_card.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class Recharge extends StatefulWidget {
  const Recharge({super.key});

  @override
  State<Recharge> createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  void recharge() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Recharge"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
              0.03,
              0.2,
            ],
          ),
        ),

        child: Column(
          children: [
            SizedBox(
              height: const MyDimensions().spaceHeight + 30,
            ),

            // the white container
            const WhiteCard(
              top: 20,
              child: WhiteCardContent(),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteCardContent extends StatelessWidget {
  const WhiteCardContent({
    super.key,
  });

  void recharge() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RechargeCard(
              value: 5,
            ),
            RechargeCard(
              value: 10,
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RechargeCard(
              value: 25,
            ),
            RechargeCard(
              value: 50,
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DigitInput(),
            DigitInput(),
            DigitInput(),
          ],
        ),
        Text('Enter card otp', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal),),
        // const SizedBox(height: 20),

        // the sing up button
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: const MyDimensions().bottomButtonHeight),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: recharge,
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(
                    Size(300, 60),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer),
                ),
                child: Text("Continue",
                    style: Theme.of(context).textTheme.labelLarge),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RechargeCard extends StatelessWidget {
  final double value;
  const RechargeCard({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      radius: 16,
      filter: 10,
      child: Container(
        color: Colors.white,
        width: 160,
        height: 90,
        alignment: Alignment.center,
        child: Text('\$$value', style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}

class DigitInput extends StatelessWidget {
  const DigitInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 68,
      child: TextField(
        onChanged: (value) {
          FocusScope.of(context).nextFocus();
        },
        style: Theme.of(context).textTheme.labelLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}

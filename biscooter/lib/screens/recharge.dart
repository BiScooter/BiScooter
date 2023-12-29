// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:biscooter/services/connection.dart';
import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/services/user.dart';
import 'package:biscooter/widget/shadow_card.dart';
import 'package:biscooter/widget/white_card.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class Recharge extends StatefulWidget {
  final Function refresh;
  const Recharge({super.key, required this.refresh});

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
            WhiteCard(
              top: 20,
              child: WhiteCardContent(refresh: widget.refresh,),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteCardContent extends StatefulWidget {
  final Function refresh;
  const WhiteCardContent({
    super.key, required this.refresh,
  });

  @override
  State<WhiteCardContent> createState() => _WhiteCardContentState();
}

class _WhiteCardContentState extends State<WhiteCardContent> {
  double chosenValue = 0;

  final _digit0 = TextEditingController();
  final _digit1 = TextEditingController();
  final _digit2 = TextEditingController();

  void recharge() async {
    if (_digit0.text == "" || _digit1.text == "" || _digit2.text == "") {
      Fluttertoast.showToast(
        msg: "Insert a card OTP",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
      return;
    }

    try {
      Response response = await post(
        Uri.parse("${const Connection().baseUrl}/users/Transactions/${User().getId}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "CARDOTP": int.parse(_digit0.text) * 100 +
              int.parse(_digit1.text) * 10 +
              int.parse(_digit2.text),
          "STATUS": "Deposit",
          "AMOUNT": chosenValue,
          "DATE": DateTime.now().toString(),
        }),
      );

      if (response.statusCode == 200) {
        User().setBalance = User().getBalance + chosenValue;
        if (mounted) {
          Fluttertoast.showToast(
          msg: "Transaction done",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
          widget.refresh();
          Navigator.pop(context);
        }
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  setChosenValue(double value) {
    setState(() {
      chosenValue = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RechargeCard(
              chosenValue: chosenValue,
              value: 5,
              onPressed: setChosenValue,
            ),
            RechargeCard(
              chosenValue: chosenValue,
              value: 10,
              onPressed: setChosenValue,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RechargeCard(
              chosenValue: chosenValue,
              value: 25,
              onPressed: setChosenValue,
            ),
            RechargeCard(
              chosenValue: chosenValue,
              value: 50,
              onPressed: setChosenValue,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DigitInput(digit: _digit0),
            DigitInput(digit: _digit1),
            DigitInput(digit: _digit2),
          ],
        ),
        Text(
          'Enter card otp',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.normal),
        ),
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

class RechargeCard extends StatefulWidget {
  final double chosenValue;
  final Function onPressed;
  final double value;
  const RechargeCard({
    super.key,
    required this.value,
    required this.onPressed,
    required this.chosenValue,
  });

  @override
  State<RechargeCard> createState() => _RechargeCardState();
}

class _RechargeCardState extends State<RechargeCard> {
  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      radius: 16,
      filter: 10,
      child: GestureDetector(
        onTap: () => widget.onPressed(widget.value),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: (widget.value == widget.chosenValue)
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent, // Color of the border
              width: 2, // Width of the border
            ),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          width: 160,
          height: 90,
          alignment: Alignment.center,
          child: Text('\$ ${widget.value}',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}

class DigitInput extends StatelessWidget {
  final TextEditingController digit;
  const DigitInput({
    super.key,
    required this.digit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 68,
      child: TextField(
        controller: digit,
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

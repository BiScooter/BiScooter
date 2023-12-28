// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:biscooter/services/connection.dart';
import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/services/user.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/shadow_card.dart';
import "package:flutter/material.dart";
import 'package:biscooter/widget/white_card.dart';
import 'package:http/http.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});
  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  final double _balanceCardWidth = 320;
  final double _balanceCardHeight = 200;

  final double _balance = 10.50;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
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
            // this column contains the white cared which contains the transaction history, and the bottom button
            Column(
              children: [
                SizedBox(
                  height: const MyDimensions().spaceHeight + 70,
                ),
                // the white card container
                WhiteCard(
                  top: 0,
                  child: WhiteCardContent(
                    spareHeight: _balanceCardHeight,
                  ),
                ),
              ],
            ),

            // this is the floating balance card
            BalanceCard(
              balanceCardWidth: _balanceCardWidth,
              balanceCardHeight: _balanceCardHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${_balance.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    'Balance',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
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
    required double balanceCardHeight,
    required this.child,
  })  : _balanceCardWidth = balanceCardWidth,
        _balanceCardHeight = balanceCardHeight;

  final double _balanceCardWidth;
  final double _balanceCardHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: const MyDimensions().spaceHeight - 40,
      left: (MediaQuery.of(context).size.width - _balanceCardWidth) / 2,
      child: ShadowCard(
        radius: 16,
        filter: 10,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/imgs/pattern.jpg'),
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
                  Color.fromARGB(2, 0, 0, 0),
                  Color.fromARGB(62, 255, 255, 255),
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

class Transaction {
  final String date;
  final double amount;
  final String cardOtp;

  Transaction(
      {required this.date, required this.amount, required this.cardOtp});

  static Transaction fromJson(json) => Transaction(
        date: json['date'],
        amount: json['amount'],
        cardOtp: json['cardOtp'],
      );
}

class WhiteCardContent extends StatefulWidget {
  final double spareHeight;
  const WhiteCardContent({
    super.key,
    required this.spareHeight,
  });

  static List<Transaction> transactionHistory = [
    Transaction(
      date: '12/12/2021',
      amount: 10.50,
      cardOtp: '1234',
    ),
    Transaction(
      date: '13/12/2021',
      amount: 15.50,
      cardOtp: '1244',
    ),
    Transaction(
      date: '14/12/2021',
      amount: 20.50,
      cardOtp: '1234',
    ),
    Transaction(
      date: '12/12/2021',
      amount: 10.50,
      cardOtp: '1234',
    ),
    Transaction(
      date: '13/12/2021',
      amount: 15.50,
      cardOtp: '1244',
    ),
    Transaction(
      date: '14/12/2021',
      amount: 20.50,
      cardOtp: '1234',
    ),
  ];

  @override
  State<WhiteCardContent> createState() => _WhiteCardContentState();
}

class _WhiteCardContentState extends State<WhiteCardContent> {
  late Future<List<Transaction>?> transactionHistory;

  @override
  void initState() {
    super.initState();
    transactionHistory = getTransactionHistory();
  }

  Future<List<Transaction>?> getTransactionHistory() async {
    try {
      final response =
          await get(Uri.parse("${const Connection().baseUrl}/transactionsHistory/${User().getId}"));
      debugPrint(response.body);
      if (response.statusCode == 200) {
        // Decode the response body
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map<Transaction>(Transaction.fromJson).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.spareHeight / 1.5,
        ),
        Text(
          'Transaction History',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 320,
          child: FutureBuilder<List<Transaction>?>(
            future: transactionHistory,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error occurred while fetching the data'),
                  );
                }
                final data = snapshot.data;
                if (data == null || data.isEmpty) {
                  return Center(
                    child: Text('No transactions found.'),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            '\$${snapshot.data![index].amount.toStringAsFixed(2)}'),
                        titleTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                        ),
                        subtitle:
                            Text('card otp ${snapshot.data![index].cardOtp}'),
                        subtitleTextStyle:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        trailing: Text(
                          snapshot.data![index].date,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  );
                }
              }
            },
          ),
        ),
        // The bottom button
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: const MyDimensions().bottomButtonHeight),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/recharge');
                },
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

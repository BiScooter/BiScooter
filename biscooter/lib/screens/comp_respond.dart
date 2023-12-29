import 'dart:convert';

import 'package:biscooter/widget/bottom.dart';
import 'package:biscooter/widget/comp_card.dart';
import 'package:biscooter/widget/drawer.dart';
import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CompRespond extends StatefulWidget {
  const CompRespond({super.key});

  @override
  State<CompRespond> createState() => _CompRespondState();
}

class _CompRespondState extends State<CompRespond> {
  @override
  void initState() {
    super.initState();
    Complaints = FetchComplaints();
  }

  late Future<List<Complaint>?> Complaints;
  String url = "";
  Future<List<Complaint>?> FetchComplaints() async {
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Decode the response body
        List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map<Complaint>(Complaint.fromJson).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

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
              child: FutureBuilder<List<Complaint>?>(
                  future: Complaints,
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
                      final request = snapshot.data;
                      if (request == null || request.isEmpty) {
                        return Center(
                          child: Text('No Complaints found.'),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: request.map((e) {
                              return CompCard(
                                date: e.date,
                                description: e.describtion,
                                employeename: e.employeename,
                              );
                            }).toList(),
                          ),
                        );
                      }
                    }
                  })),
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

class Complaint {
  final String describtion;
  final DateTime date;
  final String employeename;

  Complaint({
    required this.employeename,
    required this.describtion,
    required this.date,
  });

  static Complaint fromJson(json) => Complaint(
      describtion: json['describtion'],
      date: json['date'],
      employeename: json['employee_name']);
}

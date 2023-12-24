import 'dart:convert';

import 'package:biscooter/screens/profile.dart';
import 'package:biscooter/services/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PreProfile extends StatefulWidget {
  const PreProfile({super.key});

  @override
  State<PreProfile> createState() => _PreProfileState();
}

class _PreProfileState extends State<PreProfile> {
  late Future<Map<String, dynamic>?> mileStone;

  @override
  void initState() {
    super.initState();
    mileStone = getUserData();
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final response = await get(Uri.parse("http://localhost:3000/user"));
      if (response.statusCode == 200) {
        // Decode the response body
        Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: mileStone,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred while fetching the user data'),
            );
          }
          // set the user service
          User.setUserService(
            snapshot.data!['id'],
            snapshot.data!['firstName'],
            snapshot.data!['middleName'],
            snapshot.data!['lastName'],
            snapshot.data!['invitationCode'],
            snapshot.data!['profileImage'],
            snapshot.data!['balance'],
            snapshot.data!['ridingTime'],
          );
          return const Profile();
        }
      },
    );
  }
}

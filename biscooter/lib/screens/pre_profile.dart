
import 'dart:convert';

import 'package:biscooter/screens/profile.dart';
import 'package:biscooter/services/connection.dart';
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
  int userID = 0;

  @override
  void initState() {
    super.initState();
    mileStone = getUserData();
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final response = await get(Uri.parse("${const Connection().baseUrl}/auth/me/${User().getId}"));
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
          // set the user service/
          final userInfo = snapshot.data!;
          // TODO: activate this and reomve the dummy
          User.setUserService(
            int.parse(userInfo['id']),
            userInfo['fname'].toString(),
            userInfo['mname'].toString(),
            userInfo['lname'].toString(),
            userInfo['invitation_code'].toString(),
            'https://i.pinimg.com/736x/70/aa/28/70aa28f678193194b4a023e542ce4775.jpg',
            double.parse(userInfo['wallet'].toString().substring(1)),
            10,
          );
          return const Profile();
        }
      },
    );
  }
}

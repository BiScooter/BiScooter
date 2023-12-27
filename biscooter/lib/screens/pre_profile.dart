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
    // try {
    //   final response = await get(Uri.parse("http://localhost:3000/user"));
    //   if (response.statusCode == 200) {
    //     // Decode the response body
    //     Map<String, dynamic> responseData = jsonDecode(response.body);
    //     return responseData;
    //   }
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
    return {
      "status": "Successfully Logged in",
      "user_info": [
        {
          "id": "2",
          "email": "mariam@gmail.com",
          "username": "mariam_amin",
          "telephone": "01100685310",
          "invitation_code": "22577",
          "fname": "Mariam",
          "mname": "A",
          "lname": " Amin",
          "password":
              "\$2b\$12\$BqB2ZA295g3AomFsZ3dpO.zM1r.N1PVijmGMaDiUn7Hut/l.u7SL6",
          "status": "5",
          "wallet": "\$7.00",
          "invited_client": null
        }
      ]
    };
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
          final userInfo = snapshot.data!['user_info'][0];
          // TODO: activate this and reomve the dummy
          User.setUserService(
            int.parse(userInfo['id']),
            userInfo['fname'].toString(),
            userInfo['mname'].toString(),
            userInfo['lname'].toString(),
            userInfo['invitation_code'].toString(),
            userInfo['mname'].toString(),
            double.parse(userInfo['wallet'].toString().substring(1)),
            10,
          );
          return const Profile();
        }
      },
    );
  }
}

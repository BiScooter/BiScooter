// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/drawer.dart';
import '../widget/card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

enum SampleItem { change_Password, Upload_photo }

class _ProfileState extends State<Profile> {
  var selectedMenu;
  int index = 0;

  final controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: MyDrawer(),
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          radius: 64,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/imgs/profile.jpg'),
                          ),
                        ),
                        Text(
                          'Mariam Amin',
                          style: TextStyle(
                              fontSize: 18, fontFamily: 'PlayfairDisplay'),
                        ),
                        Text('Wanna take a ride today?',
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'PlayfairDisplay')),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      PopupMenuButton(
                        color: Colors.white,
                        initialValue: selectedMenu,
                        // Callback that sets the selected popup menu item.
                        onSelected: (item) {
                          setState(() {});
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<SampleItem>>[
                          const PopupMenuItem(
                            value: SampleItem.change_Password,
                            child: Text('Change Password'),
                          ),
                          const PopupMenuItem<SampleItem>(
                              value: SampleItem.Upload_photo,
                              child: Text('Upload a new photo ')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(alignment: Alignment.center,
                height: 150,
                width: double.infinity,
                child: Image.asset('assets/imgs/bike.png')),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Stations",
                      style: TextStyle(
                          fontFamily: 'PlayfairDisplay', fontSize: 24),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.animateToPage(index + 1,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut);
                        setState(() {
                          index = (index + 1) % 6;
                        });
                      },
                      icon: Icon(
                        Icons.navigate_next_outlined,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 324,
                child: SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MYCard(),
                      MYCard(),
                      MYCard(),
                      MYCard(),
                      MYCard(),
                      MYCard(),
                      MYCard(),
                      MYCard(),
                      MYCard(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

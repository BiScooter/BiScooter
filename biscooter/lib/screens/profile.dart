// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../widget/drawer.dart';
import '../widget/card.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

enum SampleItem { changePassword, uploadPhoto }

class _ProfileState extends State<Profile> {
  Object? selectedMenu;
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: const MyDrawer(),
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,23.0,0,0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate());
                            },
                            icon: const Icon(
                              Icons.search_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          PopupMenuButton(
                            icon: const Icon(Icons.settings),
                            color: Colors.white,
                            initialValue: selectedMenu,
                            // Callback that sets the selected popup menu item.
                            onSelected: (item) {
                              setState(() {});
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<SampleItem>>[
                              PopupMenuItem(
                                value: SampleItem.changePassword,
                                child: const Text('Change Password'),
                                onTap: () {
                                  Navigator.pushNamed(context, '/change_password');
                                },
                              ),
                              const PopupMenuItem<SampleItem>(
                                  value: SampleItem.uploadPhoto,
                                  child: Text('Upload a new photo ')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: double.infinity,
                    child: Image.asset('assets/imgs/bike.png')),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Stations",
                        style: TextStyle(
                            fontFamily: 'PlayfairDisplay', fontSize: 24),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.animateToPage(index + 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          setState(() {
                            index = (index + 1) % 6;
                          });
                        },
                        icon: const Icon(
                          Icons.navigate_next_outlined,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 324,
                  child: SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    child: const Row(
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
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Oranges',
    'Blueberries',
    'Strawberries',
    'Raspberries',
  ];
  CustomSearchDelegate()
      : super(
        searchFieldStyle:const TextStyle(fontSize: 20) ,
          searchFieldLabel: "station",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.clear,
            color: Theme.of(context).colorScheme.primary,
          )),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String r = matchQuery[index];
        return ListTile(
          title: Text(r),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String r = matchQuery[index];
        return ListTile(
          title: Text(r),
          onTap: () {},
        );
      },
    );
  }
}

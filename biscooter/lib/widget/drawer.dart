import 'package:biscooter/widget/white_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // padding :EdgeInsets.all(10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.3,
                1,
              ],
              colors: [Color(0xffff9500), Color(0xfff75a45)],
            )),

            child: Column(
              children: [
                  CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          radius: 50,
                          child: CircleAvatar(
                            radius: 47,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/imgs/profile.jpg'),
                          ),
                        ),
                const Text(
                  'First name second name',
                  style: TextStyle(fontFamily: 'PlayfairDisplay',fontWeight: FontWeight.bold),
                )
              ],
            ),



          ),

          ListTile(
            splashColor: Theme.of(context).colorScheme.shadow,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.wallet,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text(
              'My Wallet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                /*color: Font_color,
              fontFamily: 'Montserrat')*/
              ),
            ),

            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            // splashColor:theme,
            onTap: () {
              /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  Favorite()),
                      );*/
            },
          ),


          ListTile(
            splashColor: Theme.of(context).colorScheme.shadow,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.settings_accessibility_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('My statistics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  /* color: Font_color,
              fontFamily: 'Montserrat'*/
                )),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
                      );*/
            },
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.shadow,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Invite Friends',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  /*  color: Font_color,
              fontFamily: 'Montserrat'*/
                )),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => About()),
                      );*/
            },
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.shadow,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.directions_bike_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('MY Bike & Scooter',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  /*  color: Font_color,
              fontFamily: 'Montserrat'*/
                )),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => About()),
                      );*/
            },
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.shadow,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Rental History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  /* color: Font_color,
              fontFamily: 'Montserrat'*/
                )),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
                      );*/
            },
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.shadow,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.comment,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Complaints',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  /* color: Font_color,
              fontFamily: 'Montserrat'*/
                )),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: () {
              /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
                      );*/
            },
          ),
          ListTile(
            splashColor: Theme.of(context).colorScheme.shadow,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.login,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('LOG OUT',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  /*color: Font_color,
              fontFamily: 'Montserrat'*/
                )),
            onTap: () {
              SystemNavigator.pop();
              // Do something when the item is tapped
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
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
              stops:  [
                0.3,
                1,
              ],
              colors: [Color(0xffff9500), Color(0xfff75a45)],
            )),

            child: Container(
              child: Column(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration:const  BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),

                      ),
                      child:Image.asset('assets/imgs/biscooter.png'),
                          ),
                         const  Text('First name second name',style:TextStyle(fontWeight:FontWeight.bold),)


                ],


              ),

            ),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            splashColor: Theme.of(context).colorScheme.shadow,
            leading: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  /*color: Font_color,*/
                  /*fontFamily: 'Montserrat'*/
                )),
            trailing: Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            // splashColor:theme,
            onTap: () {
              /* Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
                      );*/
            },
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
          MaterialPageRoute(builder: (context) =>  Favourit()),
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
            contentPadding:const  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            leading: Icon(
              Icons.directions_bike_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title:const  Text('MY Bike',
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
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

import 'package:biscooter/services/user.dart';
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
          const DrawerHeader(
            // padding :EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.3,
                  1,
                ],
                colors: [Color(0xffff9500), Color(0xfff75a45)],
              ),
            ),

            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  radius: 50,
                  child: CircleAvatar(
                    radius: 47,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/imgs/profile.jpg'),
                  ),
                ),
                Text(
                  'First name second name',
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const BiscooterDrawerTile(
            title: 'Home',
            icon: Icons.home_rounded,
            route: '/profile',
          ),
          const BiscooterDrawerTile(
            title: 'My Wallet',
            icon: Icons.wallet,
            route: '/my_wallet',
          ),
          const BiscooterDrawerTile(
            title: 'My Statistics',
            icon: Icons.settings_accessibility_rounded,
            route: '/my_statistics',
          ),
          const BiscooterDrawerTile(
            title: 'Invite Friends',
            icon: Icons.share,
            route: '/invite_friend',
          ),
          const BiscooterDrawerTile(
            title: 'My Biscooter',
            icon: Icons.directions_bike_rounded,
            route: '/my_biscooter',
          ),
          const BiscooterDrawerTile(
            title: 'Rental History',
            icon: Icons.history,
            route: '/rental_history',
          ),
          const BiscooterDrawerTile(
            title: 'Complaints',
            icon: Icons.comment,
            route: '/complaint_respond',
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
              User.clearLoggedIn();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/splash", (Route<dynamic> route) => false);
              // Do something when the item is tapped
            },
          ),
        ],
      ),
    );
  }
}

class BiscooterDrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  const BiscooterDrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Theme.of(context).colorScheme.shadow,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: const TextStyle(
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
        Navigator.pop(context);
        if (ModalRoute.of(context)!.settings.name != '/profile') {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(route);
        } else {
          Navigator.of(context).pushNamed(route);
        }
      },
    );
  }
}

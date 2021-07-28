import 'package:flutter/material.dart';
import '../pages/settings_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  required BuildContext context,
}) {
  final color = Colors.white;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    onTap: () {
      Navigator.pushNamed(context, SettingsPage.routeName);
    },
  );
}

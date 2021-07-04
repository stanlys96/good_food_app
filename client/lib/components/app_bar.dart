import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pages/cart.dart';

AppBar header(BuildContext context, String userEmail, iconButton) {
  signOut() async {
    Navigator.pushNamed(context, '/home');
  }

  return AppBar(
    backgroundColor: Colors.white,
    leading: iconButton(context),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(
                userEmail: userEmail,
              ),
            ),
          );
        },
        icon: FaIcon(
          FontAwesomeIcons.shoppingBag,
        ),
      ),
      IconButton(
        onPressed: () {
          signOut();
        },
        icon: FaIcon(
          FontAwesomeIcons.signOutAlt,
        ),
      ),
      SizedBox(width: 5.0),
    ],
    elevation: 0.0,
  );
}

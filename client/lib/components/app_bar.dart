import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/cart.dart';
import '../pages/favorites_page.dart';

AppBar header(BuildContext context, String email) {
  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', '');
    prefs.setString('userFullName', '');
    Navigator.pushNamed(context, '/home');
  }

  return AppBar(
    backgroundColor: Theme.of(context).accentColor,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            FavoritesPage.routeName,
            arguments: email,
          );
        },
        icon: Icon(Icons.favorite),
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CartPage.routeName,
            arguments: email,
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

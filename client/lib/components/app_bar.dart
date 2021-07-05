import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../pages/cart.dart';
import '../pages/favorites_page.dart';
import '../provider/user_provider.dart';
import '../services/authService.dart';

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
              builder: (context) => ChangeNotifierProvider<UserProvider>(
                create: (_) =>
                    UserProvider(apiService: AuthService(), email: userEmail),
                child: FavoritesPage(email: userEmail),
              ),
            ),
          );
        },
        icon: Icon(Icons.favorite),
      ),
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<UserProvider>(
                create: (_) =>
                    UserProvider(apiService: AuthService(), email: userEmail),
                child: CartPage(
                  userEmail: userEmail,
                ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './model/menu.dart';
import './model/arguments.dart';
import './pages/sign_in_page.dart';
import './pages/home_page.dart';
import './pages/sign_up_page.dart';
import './pages/main_page.dart';
import './pages/menu_detail.dart';
import './pages/favorites_page.dart';
import './pages/cart.dart';
import './services/authService.dart';
import './provider/restaurant_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(248, 247, 252, 1),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        SignInPage.routeName: (context) => SignInPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        MainPage.routeName: (context) => MainPage(),
        MenuDetailPage.routeName: (context) => MenuDetailPage(
              menu: ModalRoute.of(context)?.settings.arguments as Menu,
              email: ModalRoute.of(context)?.settings.arguments as String,
            ),
        FavoritesPage.routeName: (context) => FavoritesPage(
              email: ModalRoute.of(context)?.settings.arguments as String,
            ),
        CartPage.routeName: (context) => CartPage(
              email: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/sign_in_page.dart';
import './pages/home_page.dart';
import './pages/sign_up_page.dart';
import './pages/main_page.dart';
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
        MainPage.routeName: (context) =>
            ChangeNotifierProvider<RestaurantsProvider>(
              create: (_) => RestaurantsProvider(apiService: AuthService()),
              child: MainPage(),
            ),
      },
    );
  }
}

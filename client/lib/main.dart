import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import './common/navigation.dart';
import './model/menu.dart';
import './provider/preferences_provider.dart';
import './data/preferences/preferences_helper.dart';
import './pages/sign_in_page.dart';
import './pages/home_page.dart';
import './pages/sign_up_page.dart';
import './pages/main_page.dart';
import './pages/menu_detail.dart';
import './pages/favorites_page.dart';
import './pages/cart.dart';
import './pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          )
        ],
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: provider.themeData,
              builder: (context, child) {
                return CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: provider.isDarkTheme
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  child: Material(
                    child: child,
                  ),
                );
              },
              navigatorKey: navigatorKey,
              initialRoute: HomePage.routeName,
              routes: {
                HomePage.routeName: (context) => HomePage(),
                SignInPage.routeName: (context) => SignInPage(),
                SignUpPage.routeName: (context) => SignUpPage(),
                MainPage.routeName: (context) => MainPage(),
                MenuDetailPage.routeName: (context) => MenuDetailPage(
                      menu: ModalRoute.of(context)?.settings.arguments as Menu,
                      email:
                          ModalRoute.of(context)?.settings.arguments as String,
                    ),
                FavoritesPage.routeName: (context) => FavoritesPage(
                      email:
                          ModalRoute.of(context)?.settings.arguments as String,
                    ),
                CartPage.routeName: (context) => CartPage(
                      email:
                          ModalRoute.of(context)?.settings.arguments as String,
                    ),
                SettingsPage.routeName: (context) => SettingsPage(),
              },
            );
          },
        ));
  }
}

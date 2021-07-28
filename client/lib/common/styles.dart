import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color.fromRGBO(246, 246, 246, 1);
final Color darkPrimaryColor = Color(0xFF000000);
final Color darkSecondaryColor = Colors.brown;

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.lato(
    fontSize: 92,
    fontWeight: FontWeight.w300,
  ),
  headline2: GoogleFonts.lato(
    fontSize: 57,
    fontWeight: FontWeight.w300,
  ),
  headline3: GoogleFonts.lato(
    fontSize: 46,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.lato(
    fontSize: 32,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.lato(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.lato(
    fontSize: 19,
    fontWeight: FontWeight.w500,
  ),
  subtitle1: GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  ),
  subtitle2: GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  ),
  bodyText1: GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyText2: GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  button: GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  caption: GoogleFonts.lato(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  overline: GoogleFonts.lato(
    fontSize: 15,
    color: Color.fromRGBO(219, 219, 219, 1),
    fontWeight: FontWeight.w900,
    decoration: TextDecoration.underline,
    letterSpacing: 0,
  ),
);

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: secondaryColor,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: myTextTheme.apply(bodyColor: Colors.black),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: secondaryColor,
    unselectedItemColor: Colors.grey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF6B38FB),
      textStyle: TextStyle(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: darkPrimaryColor,
  accentColor: darkSecondaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: myTextTheme.apply(bodyColor: Colors.white),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: darkSecondaryColor,
    unselectedItemColor: Colors.grey,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xff64ffda),
      textStyle: TextStyle(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    accentColor: Colors.white70,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.deepOrangeAccent,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.black,
      secondary: Colors.deepOrangeAccent,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.green,
    ),
    unselectedWidgetColor: Colors.black,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    accentColor: Colors.black26,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.deepOrangeAccent,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white,
      secondary: Colors.deepOrangeAccent,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    unselectedWidgetColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    ),
  );
}

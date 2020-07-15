import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/layout/color_definitions.dart';
import 'package:game_explorer_flutter/screens/home/home.dart';

void main() => runApp(GameExplorer());

class GameExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Explorer',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: ColorDefinitions.light(),
        indicatorColor: ColorDefinitions.darker(),
        accentColor: ColorDefinitions.accent(),
        scaffoldBackgroundColor: ColorDefinitions.light(),
        appBarTheme: AppBarTheme(
          color: ColorDefinitions.light(),
          elevation: 0.0,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: ColorDefinitions.darker(),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: ColorDefinitions.dark(0.5)),
          bodyText2: TextStyle(color: ColorDefinitions.darker()),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: ColorDefinitions.darker(),
        indicatorColor: ColorDefinitions.light(),
        accentColor: ColorDefinitions.accent(),
        scaffoldBackgroundColor: ColorDefinitions.darker(),
        appBarTheme: AppBarTheme(
          color: ColorDefinitions.darker(),
          elevation: 0.0,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: ColorDefinitions.light(),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: ColorDefinitions.dark()),
          bodyText2: TextStyle(color: ColorDefinitions.light()),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}

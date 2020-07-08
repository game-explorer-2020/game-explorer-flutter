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
        accentColor: ColorDefinitions.accent(),
        scaffoldBackgroundColor: ColorDefinitions.light(),
        appBarTheme: AppBarTheme(
          color: ColorDefinitions.light(),
          elevation: 0.0,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: ColorDefinitions.dark(),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: ColorDefinitions.dark()),
          bodyText2: TextStyle(color: ColorDefinitions.dark()),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Nunito',
        accentColor: ColorDefinitions.accent(),
        scaffoldBackgroundColor: ColorDefinitions.dark(),
        appBarTheme: AppBarTheme(
          color: ColorDefinitions.dark(),
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
          headline6: TextStyle(color: ColorDefinitions.light()),
          bodyText2: TextStyle(color: ColorDefinitions.light()),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}

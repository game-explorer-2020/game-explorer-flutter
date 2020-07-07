import 'package:flutter/material.dart';

void main() => runApp(GameExplorer());

class GameExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Explorer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Game Explorer'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

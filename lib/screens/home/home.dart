import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/screens/explore/explore.dart';
import 'package:game_explorer_flutter/screens/feeds/feed.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'FEED'),
              Tab(text: 'EXPLORE'),
            ],
          ),
          title: Text('Game Explorer'),
        ),
        body: TabBarView(
          children: [
            Feeds(),
            Explore(),
          ],
        ),
      ),
    );
  }
}

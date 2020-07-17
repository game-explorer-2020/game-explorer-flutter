import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:game_explorer_flutter/screens/game_list/local_widgets/game_list_item.dart';
import 'package:game_explorer_flutter/services/igdb_service.dart';

class GameList extends StatefulWidget {
  GameList({Key key}) : super(key: key);

  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  ScrollController _controller;
  List<Game> _games = new List();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    this._updateGames();
    _controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: _games.isEmpty
          ? Align(child: CircularProgressIndicator(), alignment: Alignment.center)
          : RefreshIndicator(
              child: ListView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  if (index == _games.length) {
                    return Center(child: Padding(padding: EdgeInsets.all(15.0), child: CircularProgressIndicator()));
                  }
                  return Container(
                    margin: EdgeInsets.all(20.0),
                    child: GameListItem(game: _games[index]),
                  );
                },
                itemCount: _games.length + 1,
              ),
              onRefresh: _refresh,
            ),
    );
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      this._updateGames();
    }
  }

  void _updateGames() {
    IgdbService.fetchGames(_currentPage).then((response) {
      setState(() {
        _games.addAll(response);
      });
      _currentPage++;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _games.clear();
    });
    _currentPage = 0;
    _updateGames();
  }
}

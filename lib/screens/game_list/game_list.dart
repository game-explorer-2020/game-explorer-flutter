import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:game_explorer_flutter/widgets/game_list_item.dart';
import 'package:game_explorer_flutter/services/igdb_service.dart';
import 'package:game_explorer_flutter/utils/debouncer.dart';

class GameList extends StatefulWidget {
  GameList({Key key}) : super(key: key);

  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  final _debouncer = Debouncer(milliseconds: 300);
  final List<Game> _games = new List();

  ScrollController _controller;
  int _currentPage = 0;
  bool _isLoadingFirstPage = true;
  bool _isLoadingNextPage = false;
  String _searchTerm = '';

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
    if (_isLoadingFirstPage) {
      return Align(child: CircularProgressIndicator(), alignment: Alignment.center);
    }
    return Scrollbar(
      child: RefreshIndicator(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              child: TextField(
                onChanged: (term) {
                  _debouncer.run(() {
                    _searchTerm = term;
                    _updateGames(backToFirstPage: true);
                  });
                },
                style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search, color: Theme.of(context).textTheme.bodyText1.color),
                  contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
                ),
              ),
            ),
            Expanded(
              child: _games.isEmpty
                  ? Align(child: Text('No items to show.'), alignment: Alignment.center)
                  : ListView.builder(
                      controller: _controller,
                      itemBuilder: (context, index) {
                        if (index == _games.length) {
                          if (_isLoadingNextPage) {
                            return Center(child: Padding(padding: EdgeInsets.all(15.0), child: CircularProgressIndicator()));
                          }
                          return null;
                        }

                        return Container(
                          margin: EdgeInsets.all(20.0),
                          child: GameListItem(
                            gameId: _games[index].id,
                            coverUrl: _games[index].coverUrl,
                            genres: _games[index].genres,
                            name: _games[index].name,
                            platforms: _games[index].platforms,
                          ),
                        );
                      },
                      itemCount: _games.length + 1,
                    ),
            )
          ],
        ),
        onRefresh: _refresh,
      ),
    );
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange && !_isLoadingNextPage) {
      setState(() {
        _isLoadingNextPage = true;
      });
      this._updateGames();
    }
  }

  void _updateGames({backToFirstPage = false}) {
    if (backToFirstPage) {
      _currentPage = 0;
    }
    IgdbService.fetchGames(offset: _currentPage, term: _searchTerm).then((games) {
      setState(() {
        if (_currentPage == 0) {
          _games.clear();
        }

        _games.addAll(games);
        _isLoadingFirstPage = false;
        _isLoadingNextPage = false;
      });

      _currentPage++;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _games.clear();
      _isLoadingFirstPage = true;
    });
    _searchTerm = '';
    _currentPage = 0;
    _updateGames();
  }
}

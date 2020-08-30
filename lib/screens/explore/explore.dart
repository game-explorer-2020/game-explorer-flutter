import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/feed.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:game_explorer_flutter/models/layout/carousel_card.dart';
import 'package:game_explorer_flutter/screens/feeds/feed.dart';
import 'package:game_explorer_flutter/screens/game_list/game_list.dart';
import 'package:game_explorer_flutter/screens/show_game_details/show_game_details.dart';
import 'package:game_explorer_flutter/services/igdb_service.dart';
import 'package:game_explorer_flutter/widgets/horizontal_carousel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Explore extends StatefulWidget {
  Explore({Key key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with AutomaticKeepAliveClientMixin<Explore> {
  List<Game> _popularGames;
  List<Game> _favoriteGames;
  List<Feed> _favoriteFeeds;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    if (_popularGames == null || _favoriteGames == null || _favoriteFeeds == null) {
      return Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      child: ListView(
        children: <Widget>[
          HorizontalCarousel(
            title: 'Popular games',
            cards: _popularGames
                .map(
                  (game) => CarouselCard(imageUrl: game.coverUrl, onTap: () => _pushGameDetails(context, game.id)),
                )
                .toList(),
            onSeeAllClick: () => _pushGameList(context, 'Popular games', false),
          ),
          HorizontalCarousel(
            title: 'My favorite games',
            cards: _favoriteGames
                .map(
                  (game) => CarouselCard(imageUrl: game.coverUrl, onTap: () => _pushGameDetails(context, game.id)),
                )
                .toList(),
            onSeeAllClick: () => _pushGameList(context, 'My favorite games', true),
          ),
          HorizontalCarousel(
            title: 'My favorite feeds',
            cards: _favoriteFeeds
                .map(
                  (feed) => CarouselCard(imageUrl: feed.imageUrl, onTap: () => _pushArticleWebView(context, feed)),
                )
                .toList(),
            onSeeAllClick: () => _pushFavoriteFeeds(context),
          ),
        ],
      ),
      onRefresh: _updateData,
    );
  }

  void _pushGameList(BuildContext context, String title, bool favoritesOnly) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: GameList(
              favoritesOnly: favoritesOnly,
            ),
          );
        },
      ),
    );
  }

  void _pushGameDetails(BuildContext context, int gameId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Game details'),
            ),
            body: ShowGameDetails(gameId: gameId),
          );
        },
      ),
    );
  }

  void _pushFavoriteFeeds(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('My favorite feeds'),
            ),
            body: Feeds(
              favoritesOnly: true,
            ),
          );
        },
      ),
    );
  }

  void _pushArticleWebView(BuildContext context, Feed feed) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(feed.title),
            ),
            body: WebView(
              initialUrl: feed.url,
            ),
          );
        },
      ),
    );
  }

  Future<void> _updateData() async {
    _fetchPopularGames();
    _fetchFavoriteGames();
    _fetchFavoriteFeeds();
  }

  void _fetchPopularGames() {
    IgdbService.fetchGames().then((games) {
      setState(() {
        _popularGames = games;
      });
    });
  }

  void _fetchFavoriteGames() {
    IgdbService.fetchFavoriteGames().then((games) {
      setState(() {
        _favoriteGames = games;
      });
    });
  }

  void _fetchFavoriteFeeds() {
    IgdbService.fetchFavoriteFeeds().then((feeds) {
      setState(() {
        _favoriteFeeds = feeds;
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:game_explorer_flutter/models/layout/carousel_card.dart';
import 'package:game_explorer_flutter/screens/game_list/game_list.dart';
import 'package:game_explorer_flutter/screens/show_game_details/show_game_details.dart';
import 'package:game_explorer_flutter/services/igdb_service.dart';
import 'package:game_explorer_flutter/widgets/horizontal_carousel.dart';

class Explore extends StatefulWidget {
  Explore({Key key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Future<List<Game>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = IgdbService.fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: futureGames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Game> games = snapshot.data ?? [];

          return HorizontalCarousel(
            title: 'Popular games',
            cards: games
                .map(
                  (game) => CarouselCard(imageUrl: game.coverUrl, onTap: () => _pushGameDetails(context, game.id)),
                )
                .toList(),
            onSeeAllClick: () => _pushPopularGameList(context),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text("Oops... There was an error."));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _pushPopularGameList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Popular games'),
            ),
            body: GameList(),
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
}

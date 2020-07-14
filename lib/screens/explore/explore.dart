import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:game_explorer_flutter/models/layout/carousel_card.dart';
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

          return Column(
            children: [
              HorizontalCarousel(
                title: 'Popular games',
                cards: games
                    .map(
                      (game) => CarouselCard(imageUrl: game.coverUrl, onClick: null),
                    )
                    .toList(),
                onSeeAllClick: null,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Oops... There was an error."));
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

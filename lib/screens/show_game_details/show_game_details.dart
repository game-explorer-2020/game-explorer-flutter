import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/layout/carousel_card.dart';
import 'package:game_explorer_flutter/services/igdb_service.dart';
import 'package:game_explorer_flutter/models/game_details.dart';
import 'package:game_explorer_flutter/widgets/game_list_item.dart';
import 'package:game_explorer_flutter/widgets/horizontal_carousel.dart';
import 'package:jiffy/jiffy.dart';

class ShowGameDetails extends StatefulWidget {
  final int gameId;

  ShowGameDetails({Key key, @required this.gameId}) : super(key: key);

  @override
  _ShowGameDetailsState createState() => _ShowGameDetailsState();
}

class _ShowGameDetailsState extends State<ShowGameDetails> {
  GameDetails _gameDetails;
  bool _favoriteToggled = false;

  @override
  void initState() {
    super.initState();
    _fetchGameDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (_gameDetails == null) {
      return Align(child: CircularProgressIndicator(), alignment: Alignment.center);
    }

    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: GameListItem(
                  gameId: _gameDetails.id,
                  name: _gameDetails.name,
                  coverUrl: _gameDetails.coverUrl,
                  genres: _gameDetails.genres,
                  platforms: _gameDetails.platforms,
                  allowTap: false,
                  showFavoriteButton: false,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Jiffy(_gameDetails.releaseDate).format('MMM do, yyyy'),
                          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          _gameDetails.involvedCompanies[0],
                          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          child: Icon(
                            _favoriteToggled ? Icons.favorite : Icons.favorite_border,
                            color: Theme.of(context).accentColor,
                          ),
                          onTap: () => _toggleFavorite(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        if (_gameDetails.rating != null)
                          Column(
                            children: <Widget>[
                              Text(
                                _gameDetails.rating.toInt().toString(),
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(_getScoreLabel(_gameDetails.rating), style: TextStyle(color: Theme.of(context).accentColor)),
                              Text(
                                'Based on ${_gameDetails.ratingCount.toInt()}',
                                style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 11),
                              ),
                              Text(
                                'ratings',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        SizedBox(width: 5),
                        if (_gameDetails.aggregatedRating != null)
                          Column(
                            children: <Widget>[
                              Text(
                                _gameDetails.aggregatedRating.toInt().toString(),
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(_getScoreLabel(_gameDetails.aggregatedRating), style: TextStyle(color: Theme.of(context).accentColor)),
                              Text(
                                'Based on ${_gameDetails.aggregatedRatingCount.toInt()}',
                                style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 11),
                              ),
                              Text(
                                'aggregated ratings',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                      ],
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
                child: Text(
                  _gameDetails.summary,
                  textAlign: TextAlign.start,
                ),
              ),
              HorizontalCarousel(
                title: 'Similar games',
                cards: _gameDetails.similarGames
                    .map(
                      (similarGame) => CarouselCard(
                        imageUrl: similarGame.coverUrl,
                        onTap: () => _pushSimilarGameDetails(context, similarGame.id),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 20)
            ],
          ),
        ],
      ),
    );
  }

  void _fetchGameDetails() {
    IgdbService.fetchGameDetails(widget.gameId).then((gameDetails) {
      setState(() {
        _gameDetails = gameDetails;
        _favoriteToggled = _gameDetails.favorite;
      });
    });
  }

  void _pushSimilarGameDetails(BuildContext context, int gameId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Similar game details'),
            ),
            body: ShowGameDetails(gameId: gameId),
          );
        },
      ),
    );
  }

  String _getScoreLabel(double score) {
    if (score < 10) {
      return 'Awful';
    }
    if (score < 30) {
      return 'Bad';
    }
    if (score < 50) {
      return 'Fine';
    }
    if (score < 70) {
      return 'Good';
    }
    if (score < 90) {
      return 'Great';
    }
    return 'Masterpiece';
  }

  void _toggleFavorite() {
    setState(() {
      _favoriteToggled = !_favoriteToggled;
    });

    IgdbService.toggleFavoriteGame(widget.gameId);
  }
}

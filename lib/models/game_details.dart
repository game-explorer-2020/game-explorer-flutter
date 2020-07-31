import 'package:game_explorer_flutter/models/Game.dart';
import 'package:game_explorer_flutter/models/similar_game.dart';

class GameDetails extends Game {
  final DateTime releaseDate;
  final String summary;
  final List<String> involvedCompanies;
  final double rating;
  final double ratingCount;
  final double aggregatedRating;
  final double aggregatedRatingCount;
  final List<SimilarGame> similarGames;

  GameDetails(
      {id,
      name,
      coverUrl,
      genres,
      platforms,
      favorite,
      this.releaseDate,
      this.summary,
      this.involvedCompanies,
      this.rating,
      this.ratingCount,
      this.aggregatedRating,
      this.aggregatedRatingCount,
      this.similarGames})
      : super(id: id, name: name, coverUrl: coverUrl, genres: genres, platforms: platforms, favorite: favorite);

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    final Game game = Game.fromJson(json);

    return GameDetails(
      id: game.id,
      name: game.name,
      coverUrl: game.coverUrl,
      genres: game.genres,
      platforms: game.platforms,
      favorite: game.favorite,
      releaseDate: DateTime.fromMillisecondsSinceEpoch(json['releaseDate'] * 1000),
      summary: json['summary'],
      involvedCompanies: json['involvedCompanies'].cast<String>(),
      rating: json['rating'] != null ? json['rating'].toDouble() : null,
      ratingCount: json['ratingCount'] != null ? json['ratingCount'].toDouble() : null,
      aggregatedRating: json['aggregatedRating'] != null ? json['aggregatedRating'].toDouble() : null,
      aggregatedRatingCount: json['aggregatedRatingCount'] != null ? json['aggregatedRatingCount'].toDouble() : null,
      similarGames: new List<dynamic>.from(json['similarGames']).map((e) => SimilarGame.fromJson(e)).toList(),
    );
  }
}

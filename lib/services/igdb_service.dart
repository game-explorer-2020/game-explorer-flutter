import 'dart:convert';
import 'package:game_explorer_flutter/models/feed.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:game_explorer_flutter/models/game_details.dart';
import 'package:http/http.dart' as http;

class IgdbService {
  static final String baseUrl = 'http://game-explorer-unisul.herokuapp.com/api/v1';

  static Future<List<Game>> fetchGames({int page = 0, String term = ''}) async {
    final response = await http.get("$baseUrl/games?page=$page&term=$term");
    final Iterable games = json.decode(response.body);

    return games.map((game) => Game.fromJson(game)).toList();
  }

  static Future<GameDetails> fetchGameDetails(int gameId) async {
    final response = await http.get("$baseUrl/games/details/$gameId");
    return GameDetails.fromJson(json.decode(response.body));
  }

  static Future<List<Game>> fetchFavoriteGames({int page = 0, String term = ''}) async {
    final response = await http.get("$baseUrl/games/favorites?page=$page&term=$term");
    final Iterable games = json.decode(response.body);

    return games.map((game) => Game.fromJson(game)).toList();
  }

  static Future<List<Feed>> fetchFeeds({int page = 0}) async {
    final response = await http.get("$baseUrl/feeds?page=$page");
    final Iterable feeds = json.decode(response.body);

    return feeds.map((feed) => Feed.fromJson(feed)).toList();
  }

  static Future<List<Feed>> fetchFavoriteFeeds({int page = 0}) async {
    final response = await http.get("$baseUrl/feeds/favorites?page=$page");
    final Iterable feeds = json.decode(response.body);

    return feeds.map((feed) => Feed.fromJson(feed)).toList();
  }

  static Future toggleFavoriteGame(int gameId) async {
    return http.put("$baseUrl/games/favorites/$gameId");
  }

  static Future toggleFavoriteFeed(int feedId) async {
    return http.put("$baseUrl/feeds/favorites/$feedId");
  }
}

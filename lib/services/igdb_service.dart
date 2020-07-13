import 'dart:convert';
import 'package:game_explorer_flutter/models/feed.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:game_explorer_flutter/models/game_details.dart';
import 'package:http/http.dart' as http;

class IgdbService {
  static final String baseUrl = 'http://game-explorer-unisul.herokuapp.com/api/v1';

  static Future<List<Game>> fetchGames() async {
    final response = await http.get("$baseUrl/games");
    final Iterable games = json.decode(response.body);

    return games.map((game) => Game.fromJson(game)).toList();
  }

  static Future<GameDetails> fetchGameDetails(int gameId) async {
    final response = await http.get("$baseUrl/games/details/$gameId");
    return GameDetails.fromJson(json.decode(response.body));
  }

  static Future<List<Feed>> fetchFeeds() async {
    final response = await http.get("$baseUrl/feeds");
    final Iterable feeds = json.decode(response.body);

    return feeds.map((feed) => Feed.fromJson(feed)).toList();
  }
}

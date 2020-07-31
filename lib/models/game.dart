class Game {
  final int id;
  final String name;
  final String coverUrl;
  final bool favorite;
  final List<String> genres;
  final List<String> platforms;

  Game({this.id, this.name, this.coverUrl, this.favorite, this.genres, this.platforms});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      coverUrl: json['coverUrl'],
      favorite: json['favorite'],
      genres: json['genres'].cast<String>(),
      platforms: json['platforms'].cast<String>(),
    );
  }
}

class Game {
  final int id;
  final String name;
  final String coverUrl;
  final List<String> genres;
  final List<String> platforms;

  Game({this.id, this.name, this.coverUrl, this.genres, this.platforms});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      coverUrl: json['coverUrl'],
      genres: json['genres'].cast<String>(),
      platforms: json['platforms'].cast<String>(),
    );
  }
}

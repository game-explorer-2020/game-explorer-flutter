class SimilarGame {
  final int id;
  final String coverUrl;

  SimilarGame({this.id, this.coverUrl});

  factory SimilarGame.fromJson(Map<String, dynamic> json) {
    return SimilarGame(
      id: json['id'],
      coverUrl: json['coverUrl'],
    );
  }
}

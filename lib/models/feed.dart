class Feed {
  final int id;
  final String title;
  final String imageUrl;
  final bool favorite;
  final DateTime publishedAt;
  final String url;

  Feed({this.id, this.title, this.imageUrl, this.favorite, this.publishedAt, this.url});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      favorite: json['favorite'],
      publishedAt: DateTime.fromMillisecondsSinceEpoch(json['publishedAt'] * 1000),
      url: json['url'],
    );
  }
}

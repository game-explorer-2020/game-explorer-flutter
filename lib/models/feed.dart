class Feed {
  final int id;
  final String title;
  final String imageUrl;
  final DateTime publishedAt;
  final String url;

  Feed({this.id, this.title, this.imageUrl, this.publishedAt, this.url});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      publishedAt: DateTime.fromMillisecondsSinceEpoch(json['publishedAt'] * 1000),
      url: json['url'],
    );
  }
}

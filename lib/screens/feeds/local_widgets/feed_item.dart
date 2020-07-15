import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/feed.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedItem extends StatelessWidget {
  final Feed feed;

  FeedItem({@required this.feed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        GestureDetector(
          onTap: () => _pushArticleWebView(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  this.feed.imageUrl,
                  height: 132,
                  fit: BoxFit.fitWidth,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.zero,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  this.feed.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            Text(timeago.format(this.feed.publishedAt), style: TextStyle(color: Theme.of(context).textTheme.headline6.color)),
          ],
        )
      ],
    );
  }

  void _pushArticleWebView(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(feed.title),
            ),
            body: WebView(
              initialUrl: feed.url,
            ),
          );
        },
      ),
    );
  }
}

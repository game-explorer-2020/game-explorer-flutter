import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/feed.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedItem extends StatefulWidget {
  final Feed feed;

  FeedItem({Key key, @required this.feed}) : super(key: key);

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  bool _favoriteToggled = false;

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
                child: FadeInImage.memoryNetwork(
                  image: widget.feed.imageUrl,
                  placeholder: kTransparentImage,
                  height: 132,
                  fit: BoxFit.fitWidth,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.zero,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  widget.feed.title,
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
            GestureDetector(
              child: Icon(
                _favoriteToggled ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onTap: () => setState(() => _favoriteToggled = !_favoriteToggled),
            ),
            Text(timeago.format(widget.feed.publishedAt), style: TextStyle(color: Theme.of(context).textTheme.headline6.color)),
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
              title: Text(widget.feed.title),
            ),
            body: WebView(
              initialUrl: widget.feed.url,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/feed.dart';
import 'package:game_explorer_flutter/services/igdb_service.dart';
import 'local_widgets/feed_item.dart';

class Feeds extends StatefulWidget {
  final bool favoritesOnly;

  Feeds({Key key, this.favoritesOnly = false}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> with AutomaticKeepAliveClientMixin<Feeds> {
  ScrollController _controller;
  List<Feed> _feeds = new List();
  int _currentPage = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._updateFeeds();
    _controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: _feeds.isEmpty
          ? Align(child: CircularProgressIndicator(), alignment: Alignment.center)
          : RefreshIndicator(
              child: ListView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  if (index == _feeds.length) {
                    return Center(child: Padding(padding: EdgeInsets.all(15.0), child: CircularProgressIndicator()));
                  }
                  return Container(
                    margin: EdgeInsets.all(20.0),
                    child: FeedItem(feed: _feeds[index]),
                  );
                },
                itemCount: _feeds.length + 1,
              ),
              onRefresh: _refresh,
            ),
    );
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      this._updateFeeds();
    }
  }

  void _updateFeeds() {
    var method = widget.favoritesOnly ? IgdbService.fetchFavoriteFeeds(page: _currentPage) : IgdbService.fetchFeeds(page: _currentPage);

    method.then((response) {
      setState(() {
        _feeds.addAll(response);
      });
      _currentPage++;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      _feeds.clear();
    });
    _currentPage = 0;
    _updateFeeds();
  }
}

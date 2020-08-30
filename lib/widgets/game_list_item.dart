import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/screens/show_game_details/show_game_details.dart';
import 'package:game_explorer_flutter/services/igdb_service.dart';
import 'package:transparent_image/transparent_image.dart';

class GameListItem extends StatefulWidget {
  final int gameId;
  final String name;
  final String coverUrl;
  final List<String> genres;
  final List<String> platforms;
  final bool showFavoriteButton;
  final bool allowTap;
  final bool favorite;

  GameListItem(
      {Key key,
      @required this.gameId,
      @required this.name,
      @required this.coverUrl,
      @required this.genres,
      @required this.platforms,
      this.favorite,
      this.showFavoriteButton = true,
      this.allowTap = true})
      : super(key: key);

  @override
  _GameListItemState createState() => _GameListItemState();
}

class _GameListItemState extends State<GameListItem> {
  bool _favoriteToggled;
  double _containerHeight = 130;

  @override
  void initState() {
    super.initState();
    _favoriteToggled = widget.favorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _containerHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: FadeInImage.memoryNetwork(
                  image: widget.coverUrl,
                  placeholder: kTransparentImage,
                  height: _containerHeight,
                  fit: BoxFit.fitHeight,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.only(right: 10),
              ),
              onTap: widget.allowTap ? () => _pushGameDetails(context) : null,
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    widget.name,
                    maxLines: 2,
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: widget.allowTap ? () => _pushGameDetails(context) : null,
                ),
                SizedBox(height: 7),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Genres: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).textTheme.headline6.color),
                    children: [
                      TextSpan(
                        text: widget.genres.isEmpty ? 'None' : widget.genres.join(', '),
                        style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Platforms: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Theme.of(context).textTheme.headline6.color),
                    children: [
                      TextSpan(
                        text: widget.genres.isEmpty ? 'None' : widget.platforms.join(', '),
                        style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                if (widget.showFavoriteButton)
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: GestureDetector(
                      child: Icon(
                        _favoriteToggled ? Icons.favorite : Icons.favorite_border,
                        color: Theme.of(context).accentColor,
                      ),
                      onTap: () => _toggleFavorite(),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _pushGameDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Game details'),
            ),
            body: ShowGameDetails(gameId: widget.gameId),
          );
        },
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _favoriteToggled = !_favoriteToggled;
    });

    IgdbService.toggleFavoriteGame(widget.gameId);
  }
}

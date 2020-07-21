import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/game.dart';
import 'package:transparent_image/transparent_image.dart';

class GameListItem extends StatefulWidget {
  final Game game;

  GameListItem({Key key, @required this.game}) : super(key: key);

  @override
  _GameListItemState createState() => _GameListItemState();
}

class _GameListItemState extends State<GameListItem> {
  bool _favoriteToggled = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: GestureDetector(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: FadeInImage.memoryNetwork(
                image: widget.game.coverUrl,
                placeholder: kTransparentImage,
                height: 130,
                fit: BoxFit.fitHeight,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.only(right: 10),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Text(
                  widget.game.name,
                  maxLines: 2,
                  style: TextStyle(fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
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
                      text: widget.game.genres.isEmpty ? 'None' : widget.game.genres.join(', '),
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
                      text: widget.game.genres.isEmpty ? 'None' : widget.game.platforms.join(', '),
                      style: TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7),
              GestureDetector(
                child: Icon(
                  _favoriteToggled ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
                onTap: () => setState(() => _favoriteToggled = !_favoriteToggled),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class HorizontalCarousel extends StatelessWidget {
  HorizontalCarousel({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;
  final String _imageUrl = 'https://media.contentapi.ea.com/content/dam/bf/images/bfcom-migration/battlefield-1.jpg.adapt.crop191x100.1200w.jpg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 18)),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "SEE ALL"),
                    WidgetSpan(
                      child: Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ],
                  style: TextStyle(color: Theme.of(context).indicatorColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10.0),
            children: [
              _ListItem(imageUrl: this._imageUrl),
              _ListItem(imageUrl: this._imageUrl),
              _ListItem(imageUrl: this._imageUrl),
            ],
          ),
        ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  _ListItem({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        imageUrl,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}

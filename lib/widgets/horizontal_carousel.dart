import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/models/layout/carousel_card.dart';
import 'package:transparent_image/transparent_image.dart';

class HorizontalCarousel extends StatelessWidget {
  final String title;
  final List<CarouselCard> cards;
  final Function onSeeAllClick;

  HorizontalCarousel({
    @required this.title,
    @required this.cards,
    this.onSeeAllClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 5, top: 20, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 18)),
              Opacity(
                opacity: onSeeAllClick == null ? 0 : 1,
                child: FlatButton(
                  onPressed: onSeeAllClick,
                  splashColor: Colors.grey,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: 'SEE ALL'),
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
                ),
              ),
            ],
          ),
        ),
        if (cards.isEmpty)
          Padding(
            child: Center(child: Text('No items to show.')),
            padding: EdgeInsets.all(20),
          ),
        if (cards.isNotEmpty)
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(5.0),
              children: [
                for (var card in cards) _ListItem(card: card),
              ],
            ),
          ),
      ],
    );
  }
}

class _ListItem extends StatelessWidget {
  final CarouselCard card;

  _ListItem({@required this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: card.onTap,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: FadeInImage.memoryNetwork(
          image: this.card.imageUrl,
          placeholder: kTransparentImage,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}

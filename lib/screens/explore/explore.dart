import 'package:flutter/material.dart';
import 'package:game_explorer_flutter/widgets/horizontal_carousel.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HorizontalCarousel(title: 'Popular games'),
        HorizontalCarousel(title: 'My favorite games'),
        HorizontalCarousel(title: 'My favorite news'),
      ],
    );
  }
}

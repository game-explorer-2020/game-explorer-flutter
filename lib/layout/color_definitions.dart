import 'package:flutter/material.dart';

class ColorDefinitions {
  static Color dark([double opacity = 1]) => Color.fromRGBO(34, 34, 34, opacity);
  static Color light([double opacity = 1]) => Colors.white.withOpacity(opacity);
  static Color accent([double opacity = 1]) => Color.fromRGBO(23, 185, 120, opacity);
}

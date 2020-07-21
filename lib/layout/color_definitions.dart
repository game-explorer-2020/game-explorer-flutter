import 'package:flutter/material.dart';

class ColorDefinitions {
  static Color darker([double opacity = 1]) => Color.fromRGBO(34, 34, 34, opacity);
  static Color dark([double opacity = 1]) => Color.fromRGBO(73, 73, 73, opacity);
  static Color light([double opacity = 1]) => Colors.white.withOpacity(opacity);
  static Color lightGray([double opacity = 1]) => Color.fromRGBO(228, 228, 228, opacity);
  static Color accent([double opacity = 1]) => Color.fromRGBO(23, 185, 120, opacity);
}

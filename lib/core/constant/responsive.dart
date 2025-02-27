import 'package:flutter/material.dart';

class AppSize {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static double padding = 16;
  static double cardBorderRadius = 12;
  static double imageSize = 100;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    padding = screenWidth * 0.04;
    cardBorderRadius = screenWidth * 0.03;
    imageSize = screenWidth * 0.25;
  }
}
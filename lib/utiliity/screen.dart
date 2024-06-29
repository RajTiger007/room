import 'package:flutter/material.dart';

class ScreenUtility {
  static const int totalFloors = 4;
  static const double cellWidth = 50;
  static double GetScreenWdth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

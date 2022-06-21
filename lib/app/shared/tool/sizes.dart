import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static double defaultPadding = 15.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getPropScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // Our designer use iPhone 11 Pro, that's why we use 815.0
  return (inputHeight / 815.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getPropScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 414 is the layout width that designer use or you can say iPhone 11 Pro width
  return (inputWidth / 440.0) * screenWidth;
}

// android
double getHeightStatusAppBar(BuildContext context) {
  return AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
}

// For add free space vertically
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    Key? key,
    this.of = 25,
  }) : super(key: key);

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getPropScreenHeight(of),
    );
  }
}
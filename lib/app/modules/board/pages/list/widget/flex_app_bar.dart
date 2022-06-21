import 'package:flutter/material.dart';

class FlexAppbar extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          bottom: 0,
          child: Text(
            'Post List',
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              // color: themeColors.shoppingColor,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
      ],
    );
  }
}
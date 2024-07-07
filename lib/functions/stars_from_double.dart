import 'package:flutter/material.dart';

extension StarsFromDouble on double {
  List<Widget> toStars(
      {double? size, EdgeInsets padding = const EdgeInsets.all(0)}) {
    final temp = <Widget>[];

    for (double i = 0; i < this; i++) {
      if (i > 1) {
        temp.add(Padding(
          padding: padding,
          child: Icon(
            Icons.star_rounded,
            color: Colors.amber,
            size: size,
          ),
        ));
      } else {
        temp.add(Padding(
          padding: padding,
          child: Icon(
            Icons.star_half_rounded,
            color: Colors.amber,
            size: size,
          ),
        ));
      }
    }

    return temp;
  }
}

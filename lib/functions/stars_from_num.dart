import 'package:flutter/material.dart';

extension StarsFromDouble on num {
  List<Widget> toStars({
    double? size,
    EdgeInsets padding = const EdgeInsets.all(0),
  }) {
    final temp = <Widget>[];
    List<int> intFromDouble =
        List.generate(5, (index) => (this - index) >= 1 ? 1 : 0);

    for (int i = 0; i < intFromDouble.length; i++) {
      if (intFromDouble[i] == 1) {
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

extension StarFromInt on int {
  List<Widget> toStarsFromInt({
    double? size,
    EdgeInsets padding = const EdgeInsets.all(0),
  }) {
    final temp = <Widget>[];

    List<int> listIntFromint =
        List.generate(5, (index) => (this - index) >= 1 ? 1 : 0);

    for (int i = 0; i < listIntFromint.length; i++) {
      if (listIntFromint[i] == 1) {
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
            Icons.star_border,
            color: Colors.amber,
            size: size,
          ),
        ));
      }
    }
    return temp;
  }
}

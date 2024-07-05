import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum HorizontalScrollDirecion {
  previous,
  next;
}

void scrollHorizontally({
  required ScrollController controller,
  required HorizontalScrollDirecion direction,
}) {
  double offset = controller.offset;
  offset = switch (direction) {
    HorizontalScrollDirecion.previous =>
      offset <= controller.position.minScrollExtent ? 0 : offset - 100,
    HorizontalScrollDirecion.next =>
      offset >= controller.position.maxScrollExtent ? offset : offset + 100,
  };
  if (kDebugMode) {
    print(offset);
  }
  controller.animateTo(
    offset,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeIn,
  );
}

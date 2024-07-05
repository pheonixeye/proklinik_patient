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
  double _offset = controller.offset;
  _offset = switch (direction) {
    HorizontalScrollDirecion.previous =>
      _offset <= controller.position.minScrollExtent ? 0 : _offset - 100,
    HorizontalScrollDirecion.next =>
      _offset >= controller.position.maxScrollExtent ? _offset : _offset + 100,
  };
  if (kDebugMode) {
    print(_offset);
  }
  controller.animateTo(
    _offset,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeIn,
  );
}

import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;

void prettyPrint(Object? object) {
  if (kDebugMode) {
    final String prettyprint = JsonEncoder.withIndent('  ').convert(object);
    debugPrint(prettyprint);
  }
}

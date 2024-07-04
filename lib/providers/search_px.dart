import 'package:flutter/foundation.dart';
import 'package:patient/models/query_object.dart';

class PxSearchController extends ChangeNotifier {
  final QueryObject query;

  PxSearchController({
    required this.query,
  }) {
    init();
  }

  Future<void> init() async {
    //TODO: perform base search query
    if (kDebugMode) {
      print("PxSearchController().init($query)");
    }
  }
}

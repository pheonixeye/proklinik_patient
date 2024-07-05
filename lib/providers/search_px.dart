import 'package:flutter/foundation.dart';
import 'package:patient/models/query_object.dart';

class PxSearchController extends ChangeNotifier {
  final QueryObject query;

  PxSearchController({
    required this.query,
  }) {
    init();
  }

  List<String>? _doctors;
  List<String>? get doctors => _doctors;

  Future<void> init() async {
    //TODO: perform base search query
    if (kDebugMode) {
      print("PxSearchController().init($query)");
    }
    await Future.delayed(const Duration(seconds: 1), () {
      final data = <String>[];
      _doctors = data;
      notifyListeners();
      if (kDebugMode) {
        print("PxSearchController().init($_doctors)");
      }
    });
  }
}

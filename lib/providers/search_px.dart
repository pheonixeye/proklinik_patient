import 'package:flutter/foundation.dart';
import 'package:patient/constants/dummy_doctors.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/query_object.dart';

class PxSearchController extends ChangeNotifier {
  final QueryObject query;

  PxSearchController({
    required this.query,
  }) {
    init();
  }

  List<Doctor>? _doctors;
  List<Doctor>? get doctors => _doctors;

  Future<void> init() async {
    //TODO: perform base search query
    if (kDebugMode) {
      print("PxSearchController().init($query)");
    }
    await Future.delayed(const Duration(seconds: 1), () {
      final data = DOCTORS.where((e) => e.speciality_en == query.spec).toList();
      _doctors = data;
      notifyListeners();
      if (kDebugMode) {
        print("PxSearchController().init(${_doctors?.map((x) => x.name_en)})");
      }
    });
  }
}

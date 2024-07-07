import 'package:flutter/foundation.dart';
import 'package:patient/constants/dummy_clinics.dart';
import 'package:patient/constants/dummy_doctors.dart';
import 'package:patient/constants/dummy_reviews.dart';
import 'package:patient/models/query_object.dart';
import 'package:patient/models/server_response_model.dart';

class PxSearchController extends ChangeNotifier {
  final QueryObject query;

  PxSearchController({
    required this.query,
  }) {
    init();
  }

  List<ServerResponseModel>? _responseModel;
  List<ServerResponseModel>? get responseModel => _responseModel;

  Future<void> init() async {
    //TODO: perform base search query
    if (kDebugMode) {
      print("PxSearchController().init($query)");
    }
    await Future.delayed(const Duration(seconds: 1), () {
      _responseModel = DOCTORS.map((doctor) {
        final clinic = CLINICS.firstWhere(
            (clinic) => doctor.destinations.contains(clinic.destination));
        final reviews = REVIEWS
            .where((review) => review.doc_id == doctor.synd_id.toString())
            .toList();
        return ServerResponseModel(
          doctor: doctor,
          clinic: clinic,
          reviews: reviews,
        );
      }).toList();
      notifyListeners();
      if (kDebugMode) {
        print(
            "PxSearchController().init(${_responseModel?.map((x) => x.doctor.name_en)})");
      }
    });
  }
}

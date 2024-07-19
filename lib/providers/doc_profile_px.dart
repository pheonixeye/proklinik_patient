import 'package:flutter/foundation.dart';
import 'package:patient/core/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_models/models/server_response_model.dart';

class PxDocProfile extends ChangeNotifier {
  final String docId;

  PxDocProfile({required this.docId}) {
    _init();
  }

  ServerResponseModel? _responseModel;
  ServerResponseModel? get responseModel => _responseModel;

  Future<void> _init() async {
    _responseModel = await PocketbaseHelper.doctorProfileQuery(docId);
    notifyListeners();
    // await Future.delayed(
    //   const Duration(seconds: 1),
    //   () {
    //     final doctor =
    //         DOCTORS.firstWhere((doc) => doc.synd_id == int.parse(docId));
    //     final clinic = CLINICS.firstWhere(
    //         (clinic) => doctor.destinations.contains(clinic.destination));
    //     final reviews = REVIEWS
    //         .where((review) => review.doc_id == doctor.synd_id.toString())
    //         .toList();
    //     _responseModel = ServerResponseModel(
    //       doctor: doctor,
    //       clinic: clinic,
    //       reviews: reviews,
    //     );
    //     notifyListeners();
    //     if (kDebugMode) {
    //       print("PxDocProfile().init(${_responseModel?.doctor.name_en})");
    //     }
    //   },
    // );
    if (kDebugMode) {
      print("PxDocProfile().init(${_responseModel?.doctor.name_en})");
    }
  }
}

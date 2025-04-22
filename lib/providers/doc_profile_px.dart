import 'package:flutter/foundation.dart';
import 'package:patient/api/doctor_profile_api/doctor_profile_api.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';

class PxDocProfile extends ChangeNotifier {
  final DoctorProfileApi service;

  PxDocProfile({required this.service}) {
    _init();
  }

  SearchResponseModel? _responseModel;
  SearchResponseModel? get responseModel => _responseModel;

  Future<void> _init() async {
    _responseModel = await service.fetch();
    notifyListeners();

    if (kDebugMode) {
      print("PxDocProfile().init(${_responseModel?.doctor.name_en})");
    }
    await _updateDoctorProfileViews();
  }

  Future<void> _updateDoctorProfileViews() async {
    if (_responseModel != null) {
      await service.updateDoctorProfileViews(
        _responseModel!.doctor_website_info.id,
        {
          'views_count': _responseModel!.doctor_website_info.views_count + 1,
        },
      );
    }
  }
}

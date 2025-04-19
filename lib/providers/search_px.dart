import 'package:flutter/foundation.dart';
import 'package:patient/api/search_clinics_api/search_clinics_api.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';

class PxSearchController extends ChangeNotifier {
  final HxSearchClinics service;

  PxSearchController({required this.service}) {
    init();
  }

  List<SearchResponseModel>? _responseModel;
  List<SearchResponseModel>? get responseModel => _responseModel;

  Future<void> init() async {
    _responseModel = await service.search();
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:proklinik_patient/api/search_clinics_api/search_clinics_api.dart';
import 'package:proklinik_patient/functions/pretty_print.dart';
import 'package:proklinik_patient/models/search_response_model/search_response_model.dart';

class PxSearchController extends ChangeNotifier {
  final HxSearchClinics service;
  final String url;

  PxSearchController({
    required this.service,
    required this.url,
  }) {
    init();
  }

  static final Map<String, List<SearchResponseModel>> _cache = {};

  List<SearchResponseModel>? _responseModel;
  List<SearchResponseModel>? get responseModel => _responseModel;

  Future<void> init() async {
    if (_cache[url] != null && _cache[url]!.isNotEmpty) {
      _responseModel = _cache[url];
      notifyListeners();
      prettyPrint(
          'PxSearchController().init(result.isCached: ${_cache.keys.contains(url)})');
      return;
    }
    _responseModel = await service.search();
    notifyListeners();
    _cache[url] = _responseModel ?? [];
  }
}

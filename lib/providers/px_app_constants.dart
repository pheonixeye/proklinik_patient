import 'package:flutter/material.dart';
import 'package:patient/api/app_constants_api/app_constants_api.dart';
import 'package:patient/models/app_constants_model/app_constants_model.dart';

class PxAppConstants extends ChangeNotifier {
  final AppConstantsApi service;

  PxAppConstants({required this.service}) {
    _init();
  }

  static AppConstantsResponseModel? _model;
  AppConstantsResponseModel? get model => _model;

  Future<void> _init() async {
    _model = await service.fetchBaseModels();
    notifyListeners();
    debugPrint('PxAppConstants._init()');
  }
}

import 'package:flutter/material.dart';
import 'package:proklinik_patient/api/visits_api/visits_api.dart';
import 'package:proklinik_patient/functions/pretty_print.dart';
import 'package:proklinik_patient/models/visit/visit_response_model.dart';

class PxVisits extends ChangeNotifier {
  final VisitsApi service;

  PxVisits({required this.service});

  VisitResponseModel? _visitResponseModel;
  VisitResponseModel? get visitResponseModel => _visitResponseModel;

  void setVisitModel(VisitResponseModel? model) {
    _visitResponseModel ??= model;
    if (model != null) {
      _visitResponseModel = VisitResponseModel.fromJson({
        ...model.toJson(),
      });
    } else {
      _visitResponseModel = null;
    }
    notifyListeners();
    prettyPrint(_visitResponseModel);
  }

  Future<void> createVisit() async {
    try {
      await service.createVisit(_visitResponseModel!);
      _visitResponseModel = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

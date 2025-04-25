// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:patient/api/patient_review_api/patient_review_api.dart';
import 'package:patient/models/review/review_response_model.dart';
import 'package:patient/models/visit/visit_response_model.dart';

class PxPatientReviews extends ChangeNotifier {
  final String visit_id;
  final PatientReviewApi service;

  PxPatientReviews({
    required this.visit_id,
    required this.service,
  }) {
    init();
    fetchReview();
  }

  VisitResponseModel? _visitModel;
  VisitResponseModel? get visitModel => _visitModel;

  ReviewResponseModel? _review;
  ReviewResponseModel? get review => _review;

  ReviewPageState _state = ReviewPageState.editing;
  ReviewPageState get state => _state;

  void updateReview({
    String? review,
    String? review_status_id,
    int? waiting_time,
    int? stars,
  }) {
    _review = _review!.copyWith(
      stars: stars ?? _review?.stars,
      waiting_time: waiting_time ?? _review?.waiting_time,
      review: review ?? _review?.review,
      review_status_id: review_status_id ?? _review?.review_status_id,
    );
    notifyListeners();
  }

  Future<void> init() async {
    _visitModel = await service.fetchVisit(visit_id);
    notifyListeners();
    if (_visitModel != null) {
      _review = ReviewResponseModel(
        id: '',
        doc_id: _visitModel!.doc_id,
        clinic_id: visitModel!.clinic_id,
        visit_id: visit_id,
        patient_id: visitModel!.patient_id,
        review_status_id: '',
        review: '',
        stars: 0,
        waiting_time: 0,
        patient_name: visitModel!.patient_name,
        patient_phone: visitModel!.patient_phone,
        patient_email: visitModel!.patient_email,
        created: '',
      );
      notifyListeners();
    }
  }

  void updateState(ReviewPageState value) {
    _state = value;
    notifyListeners();
  }

  Future<void> fetchReview() async {
    _review = await service.fetchReview(visit_id);
    notifyListeners();
    if (review != null) {
      updateState(ReviewPageState.thankyou);
    }
  }

  Future<void> submitReview() async {
    await service.submitReview(review!);
  }
}

enum ReviewPageState {
  editing,
  thankyou;
}

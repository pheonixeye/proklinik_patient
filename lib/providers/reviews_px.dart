// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:patient/core/pocketbase/pocketbase_helper.dart';
import 'package:patient/models/booking_data.dart';
import 'package:patient/models/clinic.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/review.dart';

class PxReviews extends ChangeNotifier {
  final String visit_id;
  final String month;
  final String year;

  PxReviews({
    required this.visit_id,
    required this.month,
    required this.year,
  }) {
    fetchReview();
    _review = Review.initial();
    date = DateTime(int.parse(year), int.parse(month));
    visitsCollection = 'visits_${date.month}_${date.year}';
    fetchBookingData();
  }

  late final DateTime date;

  late final String visitsCollection;

  Map<String, dynamic>? _data;
  Map<String, dynamic>? get data => _data;

  BookingData? _bookingData;
  BookingData? get bookingData => _bookingData;

  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  Clinic? _clinic;
  Clinic? get clinic => _clinic;

  late Review _review;
  Review get review => _review;

  bool _hasError = false;
  bool get hasError => _hasError;

  ReviewPageState _state = ReviewPageState.editing;
  ReviewPageState get state => _state;

  void updateReview({
    String? user_name,
    String? body,
    String? date_time,
    int? waiting_time,
    int? stars,
  }) {
    _review = _review.copyWith(
      user_name: user_name ?? _bookingData?.user_name,
      body: body ?? _review.body,
      date_time: _bookingData?.date_time,
      waiting_time: waiting_time ?? _review.waiting_time,
      stars: stars ?? _review.stars,
      doc_id: bookingData?.doc_id,
      doc_rel: bookingData?.doc_id,
      clinic_rel: bookingData?.clinic_id,
      visit_id: visit_id,
    );
    notifyListeners();
  }

  Future<void> fetchBookingData() async {
    try {
      final result = await PocketbaseHelper.fetchClinicVisit(
        visit_id: visit_id,
        visitsCollection: visitsCollection,
      );
      _data = result;
      _bookingData = BookingData.fromJson(result);
      _doctor = Doctor.fromJson(result['expand']['doc_id']);
      _clinic = Clinic.fromJson(result['expand']['clinic_id']);
      _hasError = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _data = null;
      _bookingData = null;
      _doctor = null;
      _clinic = null;
      notifyListeners();
    }
  }

  void updateState(ReviewPageState value) {
    _state = value;
    notifyListeners();
  }

  Future<void> fetchReview() async {
    final review = await PocketbaseHelper.fetchReview(visit_id);
    if (review != null) {
      updateState(ReviewPageState.thankyou);
    }
  }

  Future<void> submitReview() async {
    await PocketbaseHelper.submitReview(review);
  }
}

enum ReviewPageState {
  editing,
  thankyou;
}

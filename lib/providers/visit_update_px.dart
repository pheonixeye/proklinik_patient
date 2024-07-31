// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:patient/core/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_models/models/booking_data.dart';
import 'package:proklinik_models/models/clinic.dart';
import 'package:proklinik_models/models/doctor.dart';

class PxVisitUpdate extends ChangeNotifier {
  PxVisitUpdate({
    required this.visit_id,
    required this.month,
    required this.year,
  }) {
    date = DateTime(int.parse(year), int.parse(month));
    visitsCollection = 'visits_${date.month}_${date.year}';
    fetchBookingData();
  }

  final String visit_id;
  final String month;
  final String year;

  late final DateTime date;

  late final String visitsCollection;

  Map<String, dynamic>? _data;
  Map<String, dynamic>? get data => _data;

  bool _hasError = false;
  bool get hasError => _hasError;

  bool _showThankYou = false;
  bool get showThankYou => _showThankYou;

  BookingCardState _state = BookingCardState.data;
  BookingCardState get state => _state;

  BookingData? _bookingData;
  BookingData? get bookingData => _bookingData;

  BookingData? _newBookingData;
  BookingData? get newBookingData => _newBookingData;

  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  Clinic? _clinic;
  Clinic? get clinic => _clinic;

  void changeState(BookingCardState state) {
    _state = state;
    notifyListeners();
  }

  void updateBookingDataState(BookingData value) {
    _bookingData = value;
    notifyListeners();
  }

  void setNewBookingDataState(BookingData value) {
    _newBookingData = value;
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
      _newBookingData = BookingData.fromJson(result);
      _doctor = Doctor.fromJson(result['expand']['doc_id']);
      _clinic = Clinic.fromJson(result['expand']['clinic_id']);
      _hasError = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _data = null;
      _bookingData = null;
      _newBookingData = null;
      _doctor = null;
      _clinic = null;
      notifyListeners();
    }
  }

  void updateShowThankYou() {
    _showThankYou = true;
    notifyListeners();
  }

  Future<void> updateBookingData({
    required Map<String, dynamic> update,
  }) async {
    await PocketbaseHelper.updateClinicVisit(
      visit_id: visit_id,
      visitsCollection: visitsCollection,
      update: update,
    );
  }
}

enum BookingCardState {
  data,
  schedule,
  confirm;
}

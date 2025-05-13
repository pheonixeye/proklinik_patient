// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:proklinik_patient/api/visits_api/visits_api.dart';
import 'package:proklinik_patient/models/visit/visit.dart';

class PxVisitUpdate extends ChangeNotifier {
  PxVisitUpdate({
    required this.visit_id,
    required this.service,
  }) {
    _fetchBookingData();
  }

  final String visit_id;
  final VisitsApi service;

  bool _hasError = false;
  bool get hasError => _hasError;

  bool _showThankYou = false;
  bool get showThankYou => _showThankYou;

  BookingCardState _state = BookingCardState.data;
  BookingCardState get state => _state;

  Visit? _visit;
  Visit? get visit => _visit;

  Visit? _updatedVisit;
  Visit? get updatedVisit => _updatedVisit;

  bool? get visitDatePassed =>
      (_visit != null && DateTime.now().isAfter(_visit!.visit_date));

  void changeState(BookingCardState state) {
    _state = state;
    notifyListeners();
  }

  void updateBookingDataState(Visit value) {
    _updatedVisit = value;
    notifyListeners();
  }

  Future<void> _fetchBookingData() async {
    try {
      _visit = await service.fetchVisitById(visit_id);
      _updatedVisit = _visit;
      _hasError = false;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _visit = null;
      _hasError = true;
      notifyListeners();
    }
    debugPrint('PxVisitUpdate()._fetchBookingData($visit_id)');
  }

  void updateShowThankYou() {
    _showThankYou = true;
    notifyListeners();
  }

  Future<void> updateVisitStatus(String? visit_status_id) async {
    await service.updateVisit(
      visit_id,
      {
        'visit_status_id': visit_status_id,
      },
    );
  }

  Future<void> updateVisitBookingData() async {
    await service.updateVisit(
      visit_id,
      {
        'visit_date': _updatedVisit?.visit_date.toIso8601String(),
        'day': _updatedVisit?.visit_date.day,
        'month': _updatedVisit?.visit_date.month,
        'year': _updatedVisit?.visit_date.year,
        'visit_shift': _updatedVisit?.visit_shift.toJson(),
      },
    );
  }
}

enum BookingCardState {
  data,
  schedule,
  confirm;
}

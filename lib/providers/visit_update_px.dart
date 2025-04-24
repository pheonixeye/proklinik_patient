// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:patient/api/visits_api/visits_api.dart';
import 'package:patient/models/visit/visit.dart';

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

  void changeState(BookingCardState state) {
    _state = state;
    notifyListeners();
  }

  void updateBookingDataState(Visit value) {
    _visit = value;
    notifyListeners();
  }

  Future<void> _fetchBookingData() async {
    _visit = await service.fetchVisitById(visit_id);
    _hasError = false;
    notifyListeners();
    try {} catch (e) {
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

  Future<void> updateBookingData({
    required Map<String, dynamic> update,
  }) async {
    await service.updateVisit(
      visit_id,
      update,
    );
  }
}

enum BookingCardState {
  data,
  schedule,
  confirm;
}

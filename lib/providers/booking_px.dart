import 'package:flutter/material.dart';

class PxBooking extends ChangeNotifier {
  String? _data;
  String? get data => _data;

  void setBookingData(String? value) {
    _data = value;
    notifyListeners();
  }
}

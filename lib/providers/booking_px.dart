import 'package:flutter/material.dart';
import 'package:patient/models/booking_data.dart';

class PxBooking extends ChangeNotifier {
  BookingData? _data;
  BookingData? get data => _data;

  void setBookingData(BookingData? value) {
    _data = value;
    notifyListeners();
  }
}

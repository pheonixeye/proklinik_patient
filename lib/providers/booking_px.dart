import 'package:flutter/foundation.dart';
import 'package:patient/core/pocketbase/pocketbase_helper.dart';
import 'package:patient/models/booking_data.dart';

class PxBooking extends ChangeNotifier {
  BookingData? _data;
  BookingData? get data => _data;

  void setBookingData(BookingData? value) {
    _data = value;
    notifyListeners();
  }

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  //todo: send booking request
  //todo: Send notification sms
  //todo: Send fcm notification
  //todo: formulate message (doctor, assisstant, patient)
  //TODO: include a link to update or delete booking
  Future<void> createAppointment() async {
    _isFetching = true;
    notifyListeners();
    _data = await PocketbaseHelper.sendBookingRequest(data!);
    _isFetching = false;
    notifyListeners();
  }
}

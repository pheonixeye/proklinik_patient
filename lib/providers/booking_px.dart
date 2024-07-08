import 'package:flutter/foundation.dart';
import 'package:patient/models/booking_data.dart';

class PxBooking extends ChangeNotifier {
  BookingData? _data;
  BookingData? get data => _data;

  void setBookingData(BookingData? value) {
    _data = value;
    notifyListeners();
  }

  List<BookingData> _dummyVisits = [];
  List<BookingData> get dummyVisits => _dummyVisits;
  //TODO: send booking request

  Future<void> createAppointment() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        final visit = BookingData.withoutModel(_data!);
        _dummyVisits.add(visit);
        notifyListeners();
        if (kDebugMode) {
          print("PxBooking().createAppointment(${_dummyVisits.map((x) => (
                x.user_name,
                x.user_phone
              )).toList()})");
        }
      },
    );
  }
}

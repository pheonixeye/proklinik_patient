import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:patient/functions/debug_print.dart';
import 'package:patient/models/booking_data.dart';

class NotificationsApi {
  final BookingData bookingData;

  NotificationsApi({required this.bookingData});

  Future<void> sendNotification() async {
    try {
      await http.post(
        Uri.parse('https://notification-server.fly.dev/api/notify'),
        body: jsonEncode(bookingData.toPocketbaseJson()),
        headers: {'Content-Type': 'application/json'},
      );
      dprint('NotificationsApi().sendNotification(${bookingData.user_phone})');
    } catch (e) {
      dprint(e);
    }
  }
}

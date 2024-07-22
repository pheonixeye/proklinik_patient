import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:patient/functions/debug_print.dart';
import 'package:proklinik_models/models/booking_data.dart';
import 'package:proklinik_models/models/server_notification.dart';

class NotificationsApi {
  final BookingData bookingData;
  late final NotificationType notificationType;

  NotificationsApi({required this.bookingData}) {
    notificationType = NotificationType.newBooking;
  }

  static const baseUrl = 'https://server-proklinik.fly.dev/api/v1';
  static const notifySms = '/notify-sms';
  static const notifyDoctor = '/notify-doctor';
  static const notificationtype = 'notification_type';

  ///send sms notification messages to doctor-assisstant-patient
  ///body => booking data (only)
  Future<void> sendSmsNotification() async {
    try {
      await http.post(
        Uri.parse('$baseUrl$notifySms'),
        body: jsonEncode(bookingData.toPocketbaseJson()),
        headers: {'Content-Type': 'application/json'},
      );
      dprint(
          'NotificationsApi().sendSmsNotification(${bookingData.user_phone})');
    } catch (e) {
      dprint(e);
    }
  }

  ///send main and fcm notification to doctor that a booking request was issued
  ///ensure that booking data has a doc_id field
  ///ensure to add notification_type to the request
  Future<void> sendMailAndFcmNotification() async {
    try {
      await http.post(
        Uri.parse('$baseUrl$notifyDoctor'),
        body: jsonEncode({
          ...bookingData.toPocketbaseJson(),
          notificationType: notificationType.value,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      dprint(
          'NotificationsApi().sendMainAndFcmNotification(${bookingData.user_phone})');
    } catch (e) {
      dprint(e);
    }
  }
}

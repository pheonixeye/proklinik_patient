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

  //TODO: Change on deployment
  static const baseUrl = 'https://notification-server.fly.dev/api/v1'; //prod
  // static const baseUrl = 'http://localhost:3500/api/v1'; //dev
  static const notifySms = '/notify-sms';
  static const notifyDoctor = '/notify-doctor';
  // ignore: constant_identifier_names
  static const notification_type = 'notification_type';

  ///send sms notification messages to doctor-assisstant-patient
  ///body => booking data (only)
  Future<void> sendSmsNotification() async {
    try {
      final body = jsonEncode(bookingData.toPocketbaseJson());
      final response = await http.post(
        Uri.parse('$baseUrl$notifySms'),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      // dprint('NotificationsApi().sendSmsNotification(request body : $body)');
      dprint(
          'NotificationsApi().sendSmsNotification(response body : ${response.body})');
    } catch (e) {
      dprint('NotificationsApi().sendSmsNotification($e)');
    }
  }

  ///send main and fcm notification to doctor that a booking request was issued
  ///ensure that booking data has a doc_id field
  ///ensure to add notification_type to the request
  Future<void> sendMailAndFcmNotification() async {
    try {
      final body = jsonEncode({
        ...bookingData.toPocketbaseJson(),
        notification_type: notificationType.value,
      });
      final response = await http.post(
        Uri.parse('$baseUrl$notifyDoctor'),
        body: body,
        headers: {'Content-Type': 'application/json'},
      );
      // dprint(
      //     'NotificationsApi().sendMainAndFcmNotification(request body : $body)');
      dprint(
          'NotificationsApi().sendMainAndFcmNotification(response body : ${response.body})');
    } catch (e) {
      dprint('NotificationsApi().sendMainAndFcmNotification($e)');
    }
  }
}

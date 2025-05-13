import 'package:http/http.dart' as http;
import 'package:proklinik_patient/models/server_notification/server_notification.dart';

class NotificationsApi {
  final ServerNotification notification;
  const NotificationsApi(this.notification);
  // ignore: constant_identifier_names
  static const String NOTIFICATION_SERVER_URL = 'NOTIFICATION_SERVER_URL';

  Future<void> notify() async {
    const url = String.fromEnvironment(NOTIFICATION_SERVER_URL);
    final uri = Uri.parse(url);

    await http.post(
      uri,
      body: notification.toJson(),
    );
  }
}

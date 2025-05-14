import 'package:proklinik_patient/api/notifications_api/notifications_api.dart';
import 'package:proklinik_patient/api/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_patient/models/contact_us_model/contact_us_model.dart';
import 'package:proklinik_patient/models/server_notification/server_notification.dart';

class ContactUsApi {
  const ContactUsApi();

  static const String collection = 'contact_us';

  Future<void> submitContactUsForm(ContactUsModel formModel) async {
    final _result = await PocketbaseHelper.pb.collection(collection).create(
          body: formModel.toJson(),
        );
    final _notification = ServerNotification(
      type: NotificationType.new_contact_us,
      id: _result.id,
    );

    await NotificationsApi(_notification).notify();
  }
}

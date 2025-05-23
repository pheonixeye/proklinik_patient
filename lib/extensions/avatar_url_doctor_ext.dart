import 'package:proklinik_patient/api/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_patient/models/doctor/doctor.dart';

extension AvatarUrl on Doctor {
  String get avatarUrl => avatar.isEmpty
      ? ''
      : "${PocketbaseHelper.pb.baseURL}/api/files/doctors/$id/$avatar?thumb=200x200";
}

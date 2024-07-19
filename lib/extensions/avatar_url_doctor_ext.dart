import 'package:patient/core/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_models/models/doctor.dart';

extension AvatarUrl on Doctor {
  String? get avatarUrl => avatar == null
      ? null
      : "${PocketbaseHelper.pb.baseUrl}/api/files/doctors/$id/$avatar?thumb=200x200";
}

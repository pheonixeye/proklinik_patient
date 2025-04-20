import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/models/app_constants_model/_models/attendance_type.dart';
import 'package:patient/models/app_constants_model/_models/speciality.dart';

extension AttendanceTypeForWidgets on AttendanceType {
  String formattedAttendanceType(bool isEnglish) {
    return switch ((isEnglish, name_en)) {
      (true, 'First In First Out') =>
        "Reservation required, first-come, first-served.",
      (false, 'First In First Out') =>
        "الدكتور يتطلب الحجز، الدخول باسبقية الحضور.",
      (true, 'On Appointment') => "Reservation required, On Appointment.",
      (false, 'On Appointment') => "الدكتور يتطلب الحجز، الدخول بموعد مسبق.",
      _ => '',
    };
  }
}

extension SpecialitySvgUrl on Speciality {
  String get svgUrl =>
      '${PocketbaseHelper.pb.baseURL}/api/files/specialities/$id/$image?thumb=100x100';
}

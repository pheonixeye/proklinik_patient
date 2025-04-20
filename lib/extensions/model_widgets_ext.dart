import 'package:flutter/material.dart';
import 'package:patient/api/pocketbase/pocketbase_helper.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/models/app_constants_model/_models/attendance_type.dart';
import 'package:patient/models/app_constants_model/_models/speciality.dart';
import 'package:patient/models/clinic/clinic.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

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

extension ClinicFollowupInfo on Clinic {
  String followupInfo(BuildContext context) {
    final l = context.read<PxLocale>();
    return l.isEnglish
        ? 'Follow Up Fees is $followup_fees L.E. within $followup_duration days From First Visit Day.'
        : 'الاستشارة ${followup_fees.toString().toArabicNumber(context)} جنيه لمدة عدد ${followup_duration.toString().toArabicNumber(context)} يوم من تاريخ الكشف.';
  }
}

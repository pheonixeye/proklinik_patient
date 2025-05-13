import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_patient/api/pocketbase/pocketbase_helper.dart';
import 'package:proklinik_patient/assets/assets.dart';
import 'package:proklinik_patient/extensions/avatar_url_doctor_ext.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/models/app_constants_model/_models/attendance_type.dart';
import 'package:proklinik_patient/models/app_constants_model/_models/speciality.dart';
import 'package:proklinik_patient/models/clinic/clinic.dart';
import 'package:proklinik_patient/models/doctor/doctor.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

extension ImageProviderSelector on Doctor {
  Future<ImageProvider<Object>> widgetImageProvider() async {
    late ImageProvider<Object> image;
    if (avatar.isEmpty) {
      image = AssetImage(Assets.doctorEmptyAvatar());
    } else {
      final _response = await http.get(Uri.parse(avatarUrl));
      if (_response.statusCode != 200) {
        image = AssetImage(Assets.doctorEmptyAvatar());
      } else {
        image = CachedNetworkImageProvider(avatarUrl);
      }
    }
    return image;
  }
}

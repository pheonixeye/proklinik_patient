import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/am_pm.dart';
import 'package:patient/models/schedule.dart';

extension ScheduleToLocalizedString on Schedule {
  String toLocalizedString(BuildContext context) {
    return "${context.loc.from} ${startHour.normalizeHour.toString().padLeft(1, "0").toArabicNumber(context)}:${startMin.toString().padLeft(1, "0").toArabicNumber(context)} ${startHour.amPm(context)} ${context.loc.to} ${endHour.normalizeHour.toString().padLeft(1, "0").toArabicNumber(context)}:${endMin.toString().padLeft(1, "0").toArabicNumber(context)} ${endHour.amPm(context)}";
  }
}

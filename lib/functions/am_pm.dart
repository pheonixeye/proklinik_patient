import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';

extension AmPm on int {
  String amPm(BuildContext context) {
    return this > 12 ? context.loc.pm : context.loc.am;
  }

  int get normalizeHour {
    return this > 12 ? this - 12 : this;
  }
}

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

extension NumberTranslator on String {
  String toArabicNumber(BuildContext context) {
    final isEnglish = context.read<PxLocale>().isEnglish;
    return isEnglish ? this : ArabicNumbers.convert(this);
  }
}

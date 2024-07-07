import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TagRowData {
  final String titleEn;
  final String titleAr;
  final IconData iconData;

  const TagRowData({
    required this.titleEn,
    required this.titleAr,
    required this.iconData,
  });
}

// ignore: constant_identifier_names
const List<TagRowData> ALLTAGS = [
  TagRowData(
    titleEn: "Friendly",
    titleAr: "ودود",
    iconData: Icons.eco,
  ),
  TagRowData(
    titleEn: "Good Listener",
    titleAr: "مستمع جيد",
    iconData: FontAwesomeIcons.earListen,
  ),
  TagRowData(
    titleEn: "Informative",
    titleAr: "شرحه مفصل",
    iconData: Icons.message,
  ),
  TagRowData(
    titleEn: "Hygine",
    titleAr: "نظافة",
    iconData: Icons.clean_hands,
  ),
];

TagRowData tagFromString(String tag) {
  return ALLTAGS.firstWhere((x) => x.titleEn == tag);
}

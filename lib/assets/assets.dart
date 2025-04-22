import 'dart:math';

import 'package:flutter/foundation.dart' show debugPrint;

class Assets {
  const Assets();

  ///image files
  static const String icon = 'assets/images/icon.png';
  static const String bg = 'assets/images/bg.webp';
  static const String bgSvg = 'assets/images/bg-svg.svg';
  static const String err = 'assets/images/404.svg';
  static const String construction = 'assets/images/const-svg.svg';

  ///json files
  static const String governorates = "assets/json/governorates.json";
  static const String specialities = "assets/json/specialities.json";

  ///svg speciality icons

  static String specialityImage(String specEnName) {
    return "assets/images/icons_svg/$specEnName-color.svg";
  }

  // static String doctorAvatar(int syndId) {
  //   return "assets/images/doc_avatars/av${syndId}_.jpeg";
  // }

  static final randomInt = Random().nextInt(9) + 1;
  static String doctorEmptyAvatar() {
    debugPrint('Assets().doctorEmptyAvatar($randomInt)');
    //TODO: too much function calls
    return "assets/images/doc_avatars/av${randomInt}_.jpeg";
  }

  static String offerItemImage(String id) {
    return "assets/images/offers_row/$id.jpeg";
  }
}

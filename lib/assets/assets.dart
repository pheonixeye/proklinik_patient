class Assets {
  const Assets();

  ///image files
  static const String icon = 'assets/images/icon.png';

  ///json files
  static const String governorates = "assets/json/governorates.json";
  static const String specialities = "assets/json/specialities.json";

  ///svg speciality icons

  static String specialityImage(String specEnName) {
    return "assets/images/icons_svg/$specEnName-color.svg";
  }
}

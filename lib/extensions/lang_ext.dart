extension LangExt on String {
  String switchLang() {
    if (this == 'en') {
      return "ar";
    } else if (this == 'ar') {
      return 'en';
    } else {
      throw UnimplementedError();
    }
  }
}

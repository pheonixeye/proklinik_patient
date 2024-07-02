import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart' show ChangeNotifier, Locale;

class PxLocale extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  void setLocale() {
    _locale = Locale(_lang);
    notifyListeners();
    if (kDebugMode) {
      print("PxLocale().setLocale($_locale)");
    }
  }

  String _lang = 'en';
  String get lang => _lang;

  void setLang(String value) {
    _lang = value;
  }

  bool get isEnglish => lang == 'en' && locale == const Locale("en");
}

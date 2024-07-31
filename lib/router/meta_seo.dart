import 'package:flutter/foundation.dart';
import 'package:meta_seo/meta_seo.dart';

class MetaTags {
  final String lang;
  final String page;

  MetaTags({
    required this.lang,
    required this.page,
  }) {
    init();
  }

  void init() {
    if (kIsWeb) {
      _metaSEO = MetaSEO();
    }
  }

  late final MetaSEO _metaSEO;

  MetaSEO getTags() {
    switch (lang) {
      case 'en':
        _metaSEO.ogTitle(ogTitle: "ProKliniK");
        _metaSEO.description(description: 'description');
        _metaSEO.keywords(keywords: '');
        return _metaSEO;
      case 'ar':
        _metaSEO.ogTitle(ogTitle: "العنوان");
        _metaSEO.description(description: 'الوصف');
        _metaSEO.keywords(keywords: 'بروكلينيك');
        return _metaSEO;
      default:
        throw UnimplementedError('Language Not Found.');
    }
  }
}

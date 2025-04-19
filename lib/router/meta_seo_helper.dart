import 'package:flutter/foundation.dart';
import 'package:meta_seo/meta_seo.dart';

class MetaTagsHelper {
  final String lang;
  final String page;

  final imageUrl =
      'https://server-proklinik.fly.dev/api/files/vgxvkp4rsv0rc65/ofxlhhm9p500f50/apple_touch_icon_n2esK6bgoO.png?thumb=100x100';

  MetaTagsHelper({
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

  MetaSEO getTagsHomepage() {
    switch (lang) {
      case 'en':
        _metaSEO.propertyContent(
          property: 'title',
          content:
              'ProKliniK | book an appointment online with a doctor, or via call | book labs or x-rays | and order your medications easily from the pharmacy.',
        );
        _metaSEO.description(
          description:
              'ProKliniK.. The easiest way to find the nearest Doctors, book labs or x-rays and buy your medications online.',
        );
        _metaSEO.keywords(
          keywords:
              'clinics, labs, radiology, pharmacies, book online, medical service',
        );
        _metaSEO.ogTitle(
          ogTitle:
              'ProKliniK | book an appointment online with a doctor, or via call | book labs or x-rays | and order your medications easily from the pharmacy.',
        );
        _metaSEO.ogDescription(
          ogDescription:
              'ProKliniK.. The easiest way to find the nearest Doctors, book labs or x-rays and buy your medications online.',
        );
        _metaSEO.ogImage(ogImage: imageUrl);

        _metaSEO.twitterCard(twitterCard: TwitterCard.summary);

        _metaSEO.twitterTitle(
          twitterTitle:
              'ProKliniK | book an appointment online with a doctor, or via call | book labs or x-rays | and order your medications easily from the pharmacy.',
        );

        _metaSEO.twitterDescription(
          twitterDescription:
              'ProKliniK.. The easiest way to find the nearest Doctors, book labs or x-rays and buy your medications online.',
        );

        _metaSEO.twitterImage(twitterImage: imageUrl);

        _metaSEO.robots(robotsName: RobotsName.robots, content: 'index,follow');
        return _metaSEO;
      default:
        _metaSEO.propertyContent(
          property: 'title',
          content:
              "بروكلينيك | احجز موعد مع دكتور في العيادة، أو عبر مكالمة، | احجز تحاليل او اشعة | واطلب أدويتك بسهولة من الصيدلية.",
        );
        _metaSEO.description(
            description:
                'بروكلينيك.. خدماتك الطبية كلها في مكان واحد. احجز مع اقرب دكتور، احجز تحاليل او اشعة، و اطلب روشتاتك بسهولة من اقرب صيدلية.');
        _metaSEO.keywords(
          keywords: 'عيادات، معامل، مراكز اشعة، حجز اونلاين، خدمات طبية',
        );
        _metaSEO.ogTitle(
          ogTitle:
              "بروكلينيك | احجز موعد مع دكتور في العيادة، أو عبر مكالمة، | احجز تحاليل او اشعة | واطلب أدويتك بسهولة من الصيدلية.",
        );
        _metaSEO.ogDescription(
          ogDescription:
              'بروكلينيك.. خدماتك الطبية كلها في مكان واحد. احجز مع اقرب دكتور، احجز تحاليل او اشعة، و اطلب روشتاتك بسهولة من اقرب صيدلية.',
        );
        _metaSEO.ogImage(ogImage: imageUrl);

        _metaSEO.twitterCard(twitterCard: TwitterCard.summary);

        _metaSEO.twitterTitle(
          twitterTitle:
              "بروكلينيك | احجز موعد مع دكتور في العيادة، أو عبر مكالمة، | احجز تحاليل او اشعة | واطلب أدويتك بسهولة من الصيدلية.",
        );

        _metaSEO.twitterDescription(
          twitterDescription:
              'بروكلينيك.. خدماتك الطبية كلها في مكان واحد. احجز مع اقرب دكتور، احجز تحاليل او اشعة، و اطلب روشتاتك بسهولة من اقرب صيدلية.',
        );

        _metaSEO.twitterImage(twitterImage: imageUrl);

        _metaSEO.robots(robotsName: RobotsName.robots, content: 'index,follow');

        return _metaSEO;
    }
  }
}

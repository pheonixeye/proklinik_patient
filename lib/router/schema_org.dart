import 'package:flutter/material.dart';
import 'package:flutter_schema_org/flutter_schema_org.dart';
import 'package:flutter_schema_org/schemas/contact_point.dart';
import 'package:flutter_schema_org/schemas/organization.dart';
import 'package:flutter_schema_org/schemas/postal_address.dart';

class SchemaOrgHelper {
  const SchemaOrgHelper(this.context);

  final BuildContext context;

  static const imageUrl =
      'https://server-proklinik.fly.dev/api/files/vgxvkp4rsv0rc65/ofxlhhm9p500f50/apple_touch_icon_n2esK6bgoO.png?thumb=57x57';

  static final schemaAR = SchemaOrganization(
    url: "https://www.proklinik.app/#/ar",
    logo: imageUrl,
    image: imageUrl,
    description:
        "بروكلينيك.. احجز موعد مع دكتور في العيادة، أو عبر مكالمة، احجز تحاليل او اشعة واطلب أدويتك بسهولة من الصيدلية.",
    address: SchemaPostalAddress(
      streetAddress:
          "زهراء المعادي - الشطر الثالث عشر - برج الندي - الدور الاول.",
    ),
    contactPoint: SchemaContactPoint(
      telephone: "18888",
      contactType: "customer service",
      areaServed: "مصر",
    ),
  );

  static final schemaEN = SchemaOrganization(
    url: "https://www.proklinik.app/#/en",
    logo: imageUrl,
    image: imageUrl,
    description:
        'ProkliniK... book an appointment with a doctor at the clinic, or via call, book labs or x-rays, and order your medications easily from the pharmacy.',
    address: SchemaPostalAddress(
      streetAddress:
          'Zahraa El Maadi - 13th Sector - El Nada Tower - First Floor.',
    ),
    contactPoint: SchemaContactPoint(
      telephone: "18888",
      contactType: "customer service",
      areaServed: "Egypt",
    ),
  );

  void init(String lang) {
    bool isEnglish = lang == 'en';
    SchemaOrg.writeJsonLd(
      isEnglish ? SchemaOrgHelper.schemaEN : SchemaOrgHelper.schemaAR,
      name: 'ProKliniK',
    );
  }
}

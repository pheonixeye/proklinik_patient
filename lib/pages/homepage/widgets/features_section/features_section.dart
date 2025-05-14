import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class _Feature {
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final IconData iconData;

  const _Feature({
    required this.subtitleEn,
    required this.subtitleAr,
    required this.titleEn,
    required this.titleAr,
    required this.iconData,
  });
}

const List<_Feature> _features = [
  _Feature(
    titleEn: "All Your Medical Needs In The Same Place",
    titleAr: "احتياجاتك الطبية كلها في مكان واحد",
    subtitleEn:
        "You Can Book Appointments With Doctors, Ask Labs To Get Your Sample, Get To A Radiology Center or Even Ask Prescribed Medications To Be Delivered To Your Door.",
    subtitleAr:
        "ممكن تحجز كشف و تطلب معمل يسحبلك عينة او تحجز موعد في مركز اشعة قريب و حتي تبعت روشتة للصيدلية توصلك لحد البيت.",
    iconData: FontAwesomeIcons.handHoldingHeart,
  ),
  _Feature(
    titleEn: "ProKliniK Attends To Your Details",
    titleAr: "مع بروكلينيك مفيش تفاصيل ناقصة",
    subtitleEn:
        "Your Medical Profile On ProKliniK Gets Automatically Updated With All Your Lab Test Results, Radiology Requests And Previous Prescription History, So That No Detail Is Missed.",
    subtitleAr:
        "ملفك الطبي علي بروكلينيك بيتحدث تلقائيا بنتائج فحوصاتك و اشاعاتك و الروشتات المصروفة من خلاله عشان تكون متأكد ان مفيش تفصيلة عن صحتك هتضيع.",
    iconData: FontAwesomeIcons.personChalkboard,
  ),
  _Feature(
    titleEn: "Book Online For Free & Get The Latest Offers",
    titleAr: "احجز اونلاين مجانا و استفيد و قارن العروض",
    subtitleEn:
        "ProKliniK Provides The Same Prices Offered By The Medical Service Provider, The Payment is Direct To The Provider & You Get To Find Latest And Best Offers.",
    subtitleAr:
        "مع بروكلينيك هتلاقي نفس الاسعار المتاحة من مقدم الخدمة الطبية بدون زيادة و كمان الحجز مجانا و هتقدر تستفيد باجدد العروض و الخدمات.",
    iconData: FontAwesomeIcons.handHoldingDollar,
  ),
];

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isMobile ? 600 : 350,
      width: MediaQuery.sizeOf(context).width,
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Flex(
            direction: context.isMobile ? Axis.vertical : Axis.horizontal,
            children: [
              ..._features.map((x) {
                return Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 12.0,
                        ),
                        child: Icon(
                          x.iconData,
                          size: context.isMobile ? 20 : 32,
                          color: AppTheme.mainFontColor,
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            l.isEnglish ? x.titleEn : x.titleAr,
                            style: TextStyle(
                              color: AppTheme.mainFontColor,
                              fontWeight: FontWeight.w600,
                              fontSize: context.isMobile ? 24 : 36,
                            ),
                          ),
                          subtitle: Text(
                            l.isEnglish ? x.subtitleEn : x.subtitleAr,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: context.isMobile ? 12 : 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

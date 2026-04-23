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

List<_Feature> _features = [
  // _Feature(
  //   titleEn: "All Your Medical Needs In The Same Place",
  //   titleAr: "احتياجاتك الطبية كلها في مكان واحد",
  //   subtitleEn:
  //       "You Can Book Appointments With Doctors, Ask Labs To Get Your Sample, Get To A Radiology Center or Even Ask Prescribed Medications To Be Delivered To Your Door.",
  //   subtitleAr:
  //       "ممكن تحجز كشف و تطلب معمل يسحبلك عينة او تحجز موعد في مركز اشعة قريب و حتي تبعت روشتة للصيدلية توصلك لحد البيت.",
  //   iconData: FontAwesomeIcons.handHoldingHeart.data,
  // ),
  // _Feature(
  //   titleEn: "ProKliniK Attends To Your Details",
  //   titleAr: "مع بروكلينيك مفيش تفاصيل ناقصة",
  //   subtitleEn:
  //       "Your Medical Profile On ProKliniK Gets Automatically Updated With All Your Lab Test Results, Radiology Requests And Previous Prescription History, So That No Detail Is Missed.",
  //   subtitleAr:
  //       "ملفك الطبي علي بروكلينيك بيتحدث تلقائيا بنتائج فحوصاتك و اشاعاتك و الروشتات المصروفة من خلاله عشان تكون متأكد ان مفيش تفصيلة عن صحتك هتضيع.",
  //   iconData: FontAwesomeIcons.personChalkboard.data,
  // ),
  // _Feature(
  //   titleEn: "Book Online For Free & Get The Latest Offers",
  //   titleAr: "احجز اونلاين مجانا و استفيد و قارن العروض",
  //   subtitleEn:
  //       "ProKliniK Provides The Same Prices Offered By The Medical Service Provider, The Payment is Direct To The Provider & You Get To Find Latest And Best Offers.",
  //   subtitleAr:
  //       "مع بروكلينيك هتلاقي نفس الاسعار المتاحة من مقدم الخدمة الطبية بدون زيادة و كمان الحجز مجانا و هتقدر تستفيد باجدد العروض و الخدمات.",
  //   iconData: FontAwesomeIcons.handHoldingDollar.data,
  // ),
  _Feature(
    titleEn: "Find the Right Doctor Easily",
    titleAr: "اختار الدكتور المناسب بسهولة",
    subtitleEn:
        "Search by specialty, location, or availability and instantly find doctors that match your needs. Filter results by price, rating, or gender, and see who’s available today without wasting time.",
    subtitleAr:
        "دور على الدكتور حسب التخصص أو المكان أو المواعيد المتاحة، وهتلاقي بسهولة الاختيارات المناسبة ليك. تقدر تصفي حسب السعر أو التقييم أو النوع، وتشوف مين متاح النهارده من غير تضييع وقت.",
    iconData: FontAwesomeIcons.magnifyingGlass.data,
  ),
  _Feature(
    titleEn: "Know Your Doctor Before You Book",
    titleAr: "اعرف تفاصيل الدكتور قبل ما تحجز",
    subtitleEn:
        "View complete doctor profiles including experience, qualifications, consultation fees, and clinic location. Read real patient reviews to make confident decisions before booking.",
    subtitleAr:
        "شوف كل تفاصيل الدكتور قبل الحجز زي الخبرة والمؤهلات وسعر الكشف ومكان العيادة. وكمان اقرأ تقييمات المرضى عشان تختار وانت مطمن.",
    iconData: FontAwesomeIcons.userDoctor.data,
  ),
  _Feature(
    titleEn: "Book Appointments in Seconds",
    titleAr: "احجز في ثواني",
    subtitleEn:
        "Choose a suitable time from real available slots and confirm your booking in just a few steps. No phone calls, no waiting, and you can even book without creating an account.",
    subtitleAr:
        "اختار الوقت المناسب من المواعيد المتاحة فعليًا واحجز في خطوات بسيطة جدًا. من غير مكالمات أو انتظار، وممكن كمان تحجز من غير ما تعمل حساب.",
    iconData: FontAwesomeIcons.calendarCheck.data,
  ),
  _Feature(
    titleEn: "Get Instant Confirmation & Reminders",
    titleAr: "تأكيد فوري وتذكير بالمواعيد",
    subtitleEn:
        "Receive instant confirmation after booking and get reminders before your appointment via SMS, email, or WhatsApp so you never miss your visit.",
    subtitleAr:
        "استلم تأكيد فوري بعد الحجز، وكمان توصلك تذكيرات قبل الميعاد عن طريق SMS أو الإيميل أو واتساب علشان ما تنساش.",
    iconData: FontAwesomeIcons.bell.data,
  ),
  _Feature(
    titleEn: "Manage Your Appointments Easily",
    titleAr: "تحكم في مواعيدك بسهولة",
    subtitleEn:
        "Reschedule or cancel your appointments anytime without calling the clinic. Everything is Clear with just one click.",
    subtitleAr:
        "غير أو الغي ميعادك في أي وقت من غير ما تكلم العيادة. كل حاجة واضحة وسهلة وبتتم بضغطة واحدة.",
    iconData: FontAwesomeIcons.arrowsRotate.data,
  ),
  _Feature(
    titleEn: "Transparent Pricing",
    titleAr: "أسعار واضحة بدون مفاجآت",
    subtitleEn:
        "See consultation fees clearly before booking so you know exactly what to expect. No hidden costs, with options to pay online or at the clinic.",
    subtitleAr:
        "اعرف سعر الكشف قبل ما تحجز علشان تبقى عارف كل حاجة من البداية. من غير أي رسوم مخفية، وتقدر تدفع أونلاين أو في العيادة.",
    iconData: FontAwesomeIcons.moneyBillWave.data,
  ),
  _Feature(
    titleEn: "Access Everything From Your Phone",
    titleAr: "كل خدماتك الطبية من موبايلك",
    subtitleEn:
        "Book appointments, view doctors, and manage your visits anytime from your phone with a fast and simple experience designed for your convenience.",
    subtitleAr:
        "احجز وكشف واتابع مواعيدك في أي وقت من موبايلك بسهولة وسرعة، بتجربة بسيطة ومريحة معمولة علشانك.",
    iconData: FontAwesomeIcons.mobileScreen.data,
  ),
  _Feature(
    titleEn: "Trusted & Verified Doctors",
    titleAr: "دكاترة موثوقين ومعتمدين",
    subtitleEn:
        "All doctors are verified, and reviews come from real patients to ensure you receive reliable and trustworthy healthcare choices.",
    subtitleAr:
        "كل الدكاترة موثقين، والتقييمات من مرضى حقيقيين علشان تضمن اختيار موثوق وخدمة طبية آمنة.",
    iconData: FontAwesomeIcons.shieldHalved.data,
  ),
];

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.isMobile ? 600 : 450,
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
                      if (!context.isMobile)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 6.0,
                          ),
                          child: Icon(
                            x.iconData,
                            size: context.isMobile ? 20 : 32,
                            color: AppTheme.mainFontColor,
                          ),
                        ),
                      Flexible(
                        child: ListTile(
                          title: Row(
                            spacing: 8,
                            children: [
                              if (context.isMobile)
                                Icon(
                                  x.iconData,
                                  size: context.isMobile ? 20 : 32,
                                  color: AppTheme.mainFontColor,
                                ),
                              Expanded(
                                child: Text(
                                  l.isEnglish ? x.titleEn : x.titleAr,
                                  style: TextStyle(
                                    color: AppTheme.mainFontColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: context.isMobile ? 12 : 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            l.isEnglish ? x.subtitleEn : x.subtitleAr,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: context.isMobile ? 10 : 16,
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

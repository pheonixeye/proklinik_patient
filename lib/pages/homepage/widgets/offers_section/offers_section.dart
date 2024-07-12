import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class _Offer {
  final String id;
  final String titleEn;
  final String titleAr;
  final String pricePre;
  final String pricePost;

  const _Offer({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.pricePre,
    required this.pricePost,
  });
}

const List<_Offer> _offers = [
  _Offer(
    id: "1",
    titleEn: "Teeth Cleaning",
    titleAr: "تنظيف الاسنان",
    pricePre: "500",
    pricePost: "150",
  ),
  _Offer(
    id: "2",
    titleEn: "Facial Cleansing",
    titleAr: "تنظيف البشرة",
    pricePre: "500",
    pricePost: "250",
  ),
  _Offer(
    id: "3",
    titleEn: "Laser Hair Removal",
    titleAr: "ازالة الشعر بالليزر",
    pricePre: "350",
    pricePost: "150",
  ),
  _Offer(
    id: "4",
    titleEn: "Weight Loss",
    titleAr: "انقاص الوزن",
    pricePre: "800",
    pricePost: "400",
  ),
  _Offer(
    id: "5",
    titleEn: "Metal Braces",
    titleAr: "تركيب تقويم معدني",
    pricePre: "10000",
    pricePost: "7500",
  ),
  _Offer(
    id: "6",
    titleEn: "Vision Correction",
    titleAr: "تصحيح النظر",
    pricePre: "1500",
    pricePost: "750",
  ),
  _Offer(
    id: "7",
    titleEn: "Face Peeling",
    titleAr: "تقشير الوجه",
    pricePre: "400",
    pricePost: "200",
  ),
  _Offer(
    id: "8",
    titleEn: "Vitamin D",
    titleAr: "فيتامين د",
    pricePre: "950",
    pricePost: "150",
  ),
];

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.greyBackgroundColor,
      ),
      height: 350,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: context.isMobile ? 40 : 100),
              Text(
                context.loc.pickFromOffers,
                style: TextStyle(
                  fontSize: context.isMobile ? 18 : 42,
                  fontWeight:
                      context.isMobile ? FontWeight.w500 : FontWeight.bold,
                  color: AppTheme.mainFontColor,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                iconAlignment: IconAlignment.end,
                label: Text(
                  context.loc.allOffers,
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                  ),
                ),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.green.shade500,
                  size: 10,
                ),
              ),
              SizedBox(width: context.isMobile ? 40 : 100),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<PxLocale>(
              builder: (context, l, _) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ..._offers.map((x) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              mouseCursor: SystemMouseCursors.click,
                              onTap: () {
                                //TODO: search by offer
                              },
                              child: Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            //TODO: image not showing in deployment
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    Assets.offerItemImage(x.id),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 20,
                                              left: l.isEnglish ? 20 : null,
                                              right: !l.isEnglish ? 20 : null,
                                              child: Container(
                                                width: 50,
                                                color: Colors.green.shade500,
                                                child: Builder(
                                                  builder: (context) {
                                                    final discount = 100 -
                                                        ((int.parse(x.pricePost) /
                                                                    int.parse(x
                                                                        .pricePre)) *
                                                                100)
                                                            .round();
                                                    return Text(
                                                      "${discount.toString().toArabicNumber(context)} %",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Center(
                                        child: ListTile(
                                          title: Text(
                                            l.isEnglish ? x.titleEn : x.titleAr,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: AppTheme.mainFontColor,
                                            ),
                                          ),
                                          subtitle: Text.rich(
                                            TextSpan(
                                              text: x.pricePre
                                                  .toArabicNumber(context),
                                              children: [
                                                const TextSpan(text: " "),
                                                TextSpan(
                                                    text: context.loc.pound),
                                                const TextSpan(
                                                  text: "   ",
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: x.pricePost
                                                      .toArabicNumber(context),
                                                  children: [
                                                    const TextSpan(text: " "),
                                                    TextSpan(
                                                        text:
                                                            context.loc.pound),
                                                  ],
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color:
                                                        Colors.green.shade500,
                                                  ),
                                                ),
                                              ],
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: AppTheme.mainFontColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

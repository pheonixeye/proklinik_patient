import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/tags_row.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DocDataXl extends StatelessWidget {
  const DocDataXl({super.key, required this.doctor});
  final Doctor doctor;

  //TODO: accept doctor data and rating overall

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 400,
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Column(
            children: [
              const SizedBox(height: 38),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text.rich(
                  TextSpan(
                    text: context.loc.doctor,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.green.shade500,
                    ),
                    children: [
                      const TextSpan(text: " "),
                      TextSpan(
                        text: l.isEnglish ? doctor.name_en : doctor.name_ar,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  l.isEnglish ? doctor.title_en : doctor.title_ar,
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Row(
                  children: [
                    //TODO: generate star row from double rating
                    ...List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                //TODO: fetch from ratings
                subtitle: Text(
                  "Overall Rating From 129 Visitors",
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.mainFontColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SecondaryDataItemXl(
                iconData: Icons.medical_services,
                title: context.loc.specTitle,
                data: l.isEnglish ? doctor.speciality_en : doctor.speciality_ar,
              ),
              //TODO: fetch from selected clinic
              SecondaryDataItemXl(
                iconData: Icons.pin_drop,
                title: l.isEnglish
                    ? doctor.destinations[0].areaEn
                    : doctor.destinations[0].areaAr + " : ",
                data: l.isEnglish
                    ? doctor.destinations[0].addressEn
                    : doctor.destinations[0].addressAr,
              ),
              //TODO: fetch fees from selected clinic
              SecondaryDataItemXl(
                iconData: Icons.monetization_on,
                title: context.loc.feesTitle,
                data: "${"250".toArabicNumber(context)} ${context.loc.pound}",
              ),
              //TODO: fetch from selected clinic
              SecondaryDataItemXl(
                iconData: Icons.timer,
                title: context.loc.waitingTimeTitle,
                data: "${"30".toArabicNumber(context)} ${context.loc.minutes}",
              ),
              SecondaryDataItemXl(
                iconData: Icons.phone,
                title: context.loc.ourHotlineTitle.toArabicNumber(context),
                data: context.loc.costRegularSubtitle,
              ),
              TagsRowXlSm(
                doctor: doctor,
              ),
            ],
          );
        },
      ),
    );
  }
}

class SecondaryDataItemXl extends StatelessWidget {
  const SecondaryDataItemXl({
    super.key,
    required this.iconData,
    required this.title,
    required this.data,
  });
  final IconData iconData;
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(iconData, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: title,
                style: TextStyle(
                  color: AppTheme.mainFontColor,
                ),
                children: [
                  TextSpan(
                    text: data,
                    style: TextStyle(
                      color: Colors.green.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

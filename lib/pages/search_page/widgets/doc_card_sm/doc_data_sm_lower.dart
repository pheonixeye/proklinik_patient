import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/book_row_sm.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_data_xl.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class DocDataSmLower extends StatelessWidget {
  const DocDataSmLower({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Column(
            children: [
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
              // const SizedBox(height: 10),
              const Spacer(),

              ///reserve now row
              const BookRowSm(),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/book_row_sm.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_data_xl.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class DocDataSmLower extends StatelessWidget {
  const DocDataSmLower({super.key, required this.responseModel});
  final SearchResponseModel responseModel;

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
                data: l.isEnglish
                    ? responseModel.doctor.speciality.name_en
                    : responseModel.doctor.speciality.name_ar,
              ),
              //todo: fetch from selected clinic
              SecondaryDataItemXl(
                iconData: Icons.pin_drop,
                title: l.isEnglish
                    ? "${responseModel.clinic.address_en} : "
                    : "${responseModel.clinic.address_ar} : ",
                data: l.isEnglish
                    ? responseModel.clinic.address_en
                    : responseModel.clinic.address_ar,
              ),
              //todo: fetch fees from selected clinic
              SecondaryDataItemXl(
                iconData: Icons.monetization_on,
                title: context.loc.feesTitle,
                data:
                    "${responseModel.clinic.consultation_fees.toString().toArabicNumber(context)} ${context.loc.pound}",
              ),
              //todo: fetch from selected clinic
              SecondaryDataItemXl(
                iconData: Icons.timer,
                title: context.loc.waitingTimeTitle,
                data:
                    "${responseModel.clinic_waiting_time.toString().toArabicNumber(context)} ${context.loc.minutes}",
              ),
              SecondaryDataItemXl(
                iconData: Icons.phone,
                title: context.loc.ourHotlineTitle.toArabicNumber(context),
                data: context.loc.costRegularSubtitle,
              ),
              // const SizedBox(height: 10),
              const Spacer(),

              ///reserve now row
              BookRowSm(
                responseModel: responseModel,
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/functions/stars_from_num.dart';
import 'package:proklinik_patient/models/search_response_model/search_response_model.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DocDataSmUpper extends StatelessWidget {
  const DocDataSmUpper({super.key, required this.responseModel});
  final SearchResponseModel responseModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                        text: l.isEnglish
                            ? responseModel.doctor.name_en
                            : responseModel.doctor.name_ar,
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
                  l.isEnglish
                      ? responseModel.doctor.title_en
                      : responseModel.doctor.title_ar,
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
                    //todo: generate icons from rating

                    if (responseModel.doctor_website_info.average_rating == 0)
                      ...5.0.toStars()
                    else
                      ...responseModel.doctor_website_info.average_rating
                          .toStars(),
                  ],
                ),
                //todo: Fetch from somewhere
                subtitle: responseModel.doctor_website_info.reviews_count != 0
                    ? Text(
                        "${context.loc.overallRating} ${context.loc.from} ${responseModel.doctor_website_info.reviews_count.toString().toArabicNumber(context)} ${context.loc.visitors}",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.mainFontColor,
                        ),
                      )
                    : Text(
                        context.loc.joinedRecently,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.mainFontColor,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/stars_from_double.dart';
import 'package:patient/models/server_response_model.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DocDataSmUpper extends StatelessWidget {
  const DocDataSmUpper({super.key, required this.responseModel});
  final ServerResponseModel responseModel;

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

                    ...responseModel.doctor.rating.toStars(),
                  ],
                ),
                //todo: Fetch from somewhere
                subtitle: Text(
                  "${context.loc.overallRating} ${context.loc.from} ${responseModel.reviews.length.toString().toArabicNumber(context)} ${context.loc.visitors}",
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

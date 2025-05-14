import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/functions/stars_from_num.dart';
import 'package:proklinik_patient/models/review/review.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class RatingCardXl extends StatelessWidget {
  const RatingCardXl({
    super.key,
    required this.review,
  });
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            flex: 470,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///rating text && stars
                ListTile(
                  title: Row(
                    children: [
                      //todo: better control padding
                      ...review.stars.toStarsFromInt(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(context.loc.overallRating),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            review.review,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Consumer<PxLocale>(
                    builder: (context, l, _) {
                      return ListTile(
                        title: Text(
                          review.exposedPatientName,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.mainFontColor,
                          ),
                        ),
                        subtitle: Text(
                          //todo: modify date format
                          DateFormat("dd / MM / yyyy", l.lang)
                              .format(DateTime.parse(review.created)),
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.mainFontColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 215,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///rating blue/green number
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      review.stars.toString().toArabicNumber(context),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  context.loc.doctorRating,
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

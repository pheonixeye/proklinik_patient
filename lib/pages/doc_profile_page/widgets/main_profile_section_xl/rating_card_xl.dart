import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/stars_from_double.dart';
import 'package:patient/models/review.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
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
                            review.body,
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
                          review.parseUserName(l.isEnglish, context),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.mainFontColor,
                          ),
                        ),
                        subtitle: Text(
                          //todo: modify date format
                          DateFormat("dd/MM/yyyy", l.lang)
                              .format(DateTime.parse(review.date_time)),
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

extension ParsedUserName on Review {
  String parseUserName(bool isEnglish, BuildContext context) {
    if (user_name.contains("Guest")) {
      final split = user_name.split('-');
      final name = isEnglish ? split[0] : 'زائر';
      final number = isEnglish ? split[1] : split[1].toArabicNumber(context);
      return '$name-$number';
    } else {
      return user_name;
    }
  }
}

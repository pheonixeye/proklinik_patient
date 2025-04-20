import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/stars_from_num.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/utils/utils_keys.dart';

class OverallReviewsCardXl extends StatelessWidget {
  const OverallReviewsCardXl({super.key, required this.model});
  final SearchResponseModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 16),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: ListTile(
          key: UtilsKeys.showReviewsScrollKey,
          isThreeLine: true,
          title: Text(
            context.loc.patientReviews,
            style: TextStyle(
              color: AppTheme.mainFontColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(
            Icons.star_half,
            color: Colors.green,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (model.doctor_website_info.average_rating == 0)
                      ...5.0.toStars(size: 32, padding: const EdgeInsets.all(4))
                    else
                      ...model.doctor_website_info.average_rating
                          .toStars(size: 32, padding: const EdgeInsets.all(4)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.loc.overallRating,
                      style: TextStyle(
                        color: AppTheme.mainFontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          model.doctor_website_info.average_rating == 0
                              ? "../.."
                              : "${model.doctor_website_info.average_rating.toStringAsFixed(1).toArabicNumber(context)} / ${5.toString().toArabicNumber(context)}",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${context.loc.from} ${model.doctor_website_info.reviews_count.toString().toArabicNumber(context)} ${context.loc.visitors}",
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

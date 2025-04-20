import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/avatar_url_doctor_ext.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/stars_from_num.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/utils/utils_keys.dart';
import 'package:provider/provider.dart';

class MainInfoCardXl extends StatefulWidget {
  const MainInfoCardXl({super.key, required this.model});
  final SearchResponseModel model;

  @override
  State<MainInfoCardXl> createState() => _MainInfoCardXlState();
}

class _MainInfoCardXlState extends State<MainInfoCardXl> {
  late final ImageProvider image;

  @override
  void initState() {
    if (widget.model.doctor.avatar.isEmpty) {
      image = AssetImage(Assets.doctorEmptyAvatar());
    } else {
      image = NetworkImage(widget.model.doctor.avatarUrl);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///doctor profile main card
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 235,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Consumer<PxLocale>(
          builder: (context, l, _) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///white lateral margin
                const SizedBox(width: 30),

                ///doctor image avatar
                Column(
                  children: [
                    ///white upper margin
                    const SizedBox(height: 15),
                    Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: image,
                        ),
                      ),
                    ),
                  ],
                ),

                ///white middle separator
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///white upper margin
                      const SizedBox(width: 15),

                      ///doctor main info title
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "${context.loc.doctor}  ",
                                  style: TextStyle(
                                    color: AppTheme.mainFontColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: l.isEnglish
                                          ? widget.model.doctor.name_en
                                          : widget.model.doctor.name_ar,
                                      style: TextStyle(
                                        color: AppTheme.mainFontColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${widget.model.doctor_website_info.views_count.toString().toArabicNumber(context)} ${context.loc.views}",
                                style: TextStyle(
                                  color: AppTheme.mainFontColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  l.isEnglish
                                      ? widget.model.doctor.title_en
                                      : widget.model.doctor.title_ar,
                                  style: TextStyle(
                                    color: AppTheme.mainFontColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///doctor spec && rating summary
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text.rich(
                            TextSpan(
                              text: l.isEnglish
                                  ? widget.model.doctor.speciality.name_en
                                  : widget.model.doctor.speciality.name_ar,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.appBarColor,
                              ),
                              children: [
                                const TextSpan(text: " - "),
                                TextSpan(
                                  text: l.isEnglish
                                      ? widget.model.doctor.degree.name_en
                                      : widget.model.doctor.degree.name_ar,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: AppTheme.mainFontColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              if (widget.model.doctor_website_info
                                      .average_rating ==
                                  0)
                                ...5.0.toStars(
                                    size: 32,
                                    padding: const EdgeInsets.only(left: 5))
                              else
                                ...widget
                                    .model.doctor_website_info.average_rating
                                    .toStars(
                                        size: 32,
                                        padding:
                                            const EdgeInsets.only(left: 5)),
                              const SizedBox(width: 10),
                              widget.model.doctor_website_info.reviews_count !=
                                      0
                                  ? Text(
                                      "${context.loc.overallRating} ${context.loc.from} ${widget.model.doctor_website_info.reviews_count.toString().toArabicNumber(context)} ${context.loc.visitors}",
                                      style: TextStyle(
                                        color: AppTheme.mainFontColor,
                                        fontSize: 10,
                                      ),
                                    )
                                  : Text(
                                      context.loc.joinedRecently,
                                      style: TextStyle(
                                        color: AppTheme.mainFontColor,
                                        fontSize: 10,
                                      ),
                                    ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                      text: context.loc.showAllReviews,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          //todo: Scroll to reviews
                                          Scrollable.ensureVisible(
                                            UtilsKeys.showReviewsScrollKey
                                                .currentContext!,
                                            curve: Curves.easeIn,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                        }),
                                  style: TextStyle(
                                    color: AppTheme.appBarColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                ///white lateral margin
                const SizedBox(width: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/pages/review_submission_page/widgets/thank_you_review.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/reviews_px.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class ReviewSubmissionPage extends StatefulWidget {
  const ReviewSubmissionPage({super.key});

  @override
  State<ReviewSubmissionPage> createState() => _ReviewSubmissionPageState();
}

class _ReviewSubmissionPageState extends State<ReviewSubmissionPage> {
  bool _anonymous = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxReviews>(
      builder: (context, l, r, _) {
        while (r.data == null) {
          return const CentralLoading();
        }
        while (r.hasError) {
          return Center(
            child: Text(context.loc.unknownErrorHasOccured),
          );
        }
        return ListView(
          children: [
            switch (r.state) {
              ReviewPageState.editing => Form(
                  key: formKey,
                  child: Card.outlined(
                    elevation: 6,
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            context.loc.writeAReview,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).appBarTheme.backgroundColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckboxListTile.adaptive(
                            secondary: const CircleAvatar(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                color: Colors.green,
                                width: 0.5,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(r.bookingData!.user_name),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 28.0),
                                    child: Text(context.loc.postWithNoName),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat('dd/MM/yyyy', l.lang).format(
                                  DateTime.parse(r.bookingData!.date_time),
                                ),
                              ),
                            ),
                            value: _anonymous,
                            tristate: false,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _anonymous = val;
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(context.loc.doctorRating),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RatingStars(
                                axis: Axis.horizontal,
                                value: r.review.stars.toDouble(),
                                onValueChanged: (v) {
                                  r.updateReview(
                                    stars: v.toInt(),
                                  );
                                },
                                starCount: 5,
                                starSize: 32,
                                valueLabelColor: const Color(0xff9b9b9b),
                                valueLabelTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0,
                                ),
                                valueLabelRadius: 10,
                                maxValue: 5,
                                starSpacing: 6,
                                maxValueVisibility: true,
                                valueLabelVisibility: false,
                                animationDuration:
                                    const Duration(milliseconds: 500),
                                valueLabelPadding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 8,
                                ),
                                valueLabelMargin:
                                    const EdgeInsets.only(right: 8),
                                starOffColor: const Color(0xffe7e8ea),
                                starColor: Colors.amber,
                                angle: 12,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(context.loc.message),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: context.loc.writeYourReview,
                                ),
                                onChanged: (value) {
                                  r.updateReview(
                                    body: value,
                                  );
                                },
                                minLines: null,
                                maxLines: 4,
                                expands: false,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(context.loc.waitingTime),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: context.loc.writeYourWaitingTime,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  r.updateReview(
                                      waiting_time: int.parse(value));
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return context.loc.enterWaitingTime;
                                  }
                                  return null;
                                },
                                minLines: 1,
                                maxLines: 1,
                                expands: false,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (_anonymous) {
                                  final random = Random.secure().nextInt(99999);
                                  final user_name = (_anonymous)
                                      ? 'Guest-$random'
                                      : r.bookingData!.user_name;
                                  r.updateReview(
                                    user_name: user_name,
                                  );
                                }
                                late BuildContext loadingContext;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    loadingContext = context;
                                    return const CentralLoading();
                                  },
                                );
                                await r.submitReview().whenComplete(() {
                                  Navigator.pop(loadingContext);
                                });

                                r.updateState(ReviewPageState.thankyou);
                              }
                            },
                            label: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                context.loc.submitReview,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ReviewPageState.thankyou => const ThankYouReview(),
            },
            const FooterSection(),
          ],
        );
      },
    );
  }
}

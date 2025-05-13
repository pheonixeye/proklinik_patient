import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/providers/px_doctor_reviews.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class LoadMoreReviewsCardXl extends StatelessWidget {
  const LoadMoreReviewsCardXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxDocReviews>(
      builder: (context, r, _) {
        return Container(
          height: 60,
          alignment: Alignment.center,
          color: Colors.white,
          child: r.isLoading
              ? const CircularProgressIndicator()
              : Text.rich(
                  TextSpan(
                    text: context.loc.loadMore,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        //todo: load more reviews
                        if (context.mounted) {
                          await r.fetchMoreReviews();
                        }
                      },
                  ),
                  style: TextStyle(
                    color: AppTheme.appBarColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        );
      },
    );
  }
}

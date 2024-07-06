import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patient/theme/app_theme.dart';

class LoadMoreReviewsCardXl extends StatelessWidget {
  const LoadMoreReviewsCardXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text.rich(
        TextSpan(
          text: "Load More",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              //TODO: load more reviews
            },
        ),
        style: TextStyle(
          color: AppTheme.appBarColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

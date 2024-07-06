import 'package:flutter/material.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/about_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/load_more_reviews_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/main_info_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/overall_reviews_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/rating_card_xl.dart';

class MainProfileSectionXl extends StatelessWidget {
  const MainProfileSectionXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 690,
      child: Column(
        children: [
          const MainInfoCardXl(),

          ///doctor profile about card
          const AboutCardXl(),

          ///doctor overall reviews card
          const OverallReviewsCardXl(),

          ///rating cards
          ...List.generate(10, (index) => const RatingCardXl()),

          ///load more button
          // const Divider(),
          const LoadMoreReviewsCardXl(),
        ],
      ),
    );
  }
}

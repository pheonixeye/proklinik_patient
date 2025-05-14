import 'package:flutter/material.dart';
import 'package:proklinik_patient/models/search_response_model/search_response_model.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/about_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/load_more_reviews_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/main_info_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/overall_reviews_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/rating_card_xl.dart';
import 'package:proklinik_patient/providers/px_doctor_reviews.dart';
import 'package:provider/provider.dart';

class MainProfileSectionXl extends StatelessWidget {
  const MainProfileSectionXl({
    super.key,
    required this.model,
  });
  final SearchResponseModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 690,
      child: Consumer<PxDocReviews>(
        builder: (context, r, _) {
          final _reviews = r.reviews;
          return Column(
            children: [
              MainInfoCardXl(model: model),

              ///doctor profile about card
              AboutCardXl(model: model),

              ///doctor overall reviews card
              OverallReviewsCardXl(model: model),

              ///rating cards
              //todo:
              if (_reviews != null)
                ..._reviews.map((review) => RatingCardXl(review: review)),

              ///load more button
              // const Divider(),
              const LoadMoreReviewsCardXl(),
            ],
          );
        },
      ),
    );
  }
}

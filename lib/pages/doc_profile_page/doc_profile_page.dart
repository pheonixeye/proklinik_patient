import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_info_card_sm/main_info_card_sm.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/about_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/load_more_reviews_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/main_profile_section_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/overall_reviews_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/main_profile_section_xl/rating_card_xl.dart';
import 'package:proklinik_patient/pages/doc_profile_page/widgets/side_profile_section_xl/side_profile_section_xl.dart';
import 'package:proklinik_patient/providers/doc_profile_px.dart';
import 'package:proklinik_patient/providers/px_doctor_reviews.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:proklinik_patient/widgets/central_loading/central_loading.dart';
import 'package:proklinik_patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class DocProfilePage extends StatefulWidget {
  const DocProfilePage({super.key});

  @override
  State<DocProfilePage> createState() => _DocProfilePageState();
}

class _DocProfilePageState extends State<DocProfilePage> {
  late final ScrollController _scrollController;
  late final PxDocReviews _r;

  @override
  void initState() {
    super.initState();
    _r = context.read<PxDocReviews>();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    final _toFetchMore = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    if (_toFetchMore && !_r.isLoading) {
      await _r.fetchMoreReviews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxDocProfile, PxDocReviews>(
      builder: (context, d, r, _) {
        final model = d.responseModel;
        final _reviews = r.reviews;
        while (model == null) {
          return const CentralLoading();
        }
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.greyBackgroundColor,
          ),
          child: ListView(
            controller: _scrollController,
            cacheExtent: 3000,
            shrinkWrap: true,
            children: context.isMobile
                ? [
                    const SizedBox(height: 10),
                    //todo: put new info && reservation section
                    MainInfoCardSm(model: model),
                    AboutCardXl(model: model),
                    OverallReviewsCardXl(model: model),
                    //todo
                    if (_reviews != null)
                      ..._reviews.map((review) => RatingCardXl(review: review)),
                    const LoadMoreReviewsCardXl(),
                    const SizedBox(height: 10),
                    const FooterSection(),
                  ]
                : [
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(
                          flex: 90,
                        ),

                        ///main doctor profile info section
                        MainProfileSectionXl(
                          model: model,
                        ),

                        ///central space
                        const SizedBox(width: 15),

                        ///booking info section
                        SideProfileSectionXl(model: model),
                        const Spacer(
                          flex: 90,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const FooterSection()
                  ],
          ),
        );
      },
    );
  }
}

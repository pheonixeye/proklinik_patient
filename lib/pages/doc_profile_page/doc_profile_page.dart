import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/models/server_response_model.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_info_card_sm/main_info_card_sm.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/about_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/load_more_reviews_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/main_profile_section_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/overall_reviews_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/main_profile_section_xl/rating_card_xl.dart';
import 'package:patient/pages/doc_profile_page/widgets/side_profile_section_xl/side_profile_section_xl.dart';
import 'package:patient/providers/doc_profile_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class DocProfilePage extends StatefulWidget {
  const DocProfilePage({super.key});

  @override
  State<DocProfilePage> createState() => _DocProfilePageState();
}

class _DocProfilePageState extends State<DocProfilePage> {
  static List<Widget> _desktop(ServerResponseModel model) => [
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
      ];

  static List<Widget> _mobile(ServerResponseModel model) => [
        const SizedBox(height: 10),
        //todo: put new info && reservation section
        MainInfoCardSm(model: model),
        AboutCardXl(model: model),
        OverallReviewsCardXl(model: model),
        ...model.reviews.map((review) => RatingCardXl(review: review)),
        const LoadMoreReviewsCardXl(),
        const SizedBox(height: 10),
        const FooterSection(),
      ];
  @override
  Widget build(BuildContext context) {
    return Consumer<PxDocProfile>(
      builder: (context, d, _) {
        final res = d.responseModel;
        while (res == null) {
          return const CentralLoading();
        }
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.greyBackgroundColor,
          ),
          child: ListView(
            shrinkWrap: true,
            children: context.isMobile ? _mobile(res) : _desktop(res),
          ),
        );
      },
    );
  }
}

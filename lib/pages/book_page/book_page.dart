import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/models/search_response_model/search_response_model.dart';
import 'package:proklinik_patient/pages/book_page/widgets/book_app_form.dart';
import 'package:proklinik_patient/pages/book_page/widgets/book_app_info_card.dart';
import 'package:proklinik_patient/pages/book_page/widgets/page_error_card.dart';
import 'package:proklinik_patient/providers/px_visits.dart';
import 'package:proklinik_patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class BookPage extends StatelessWidget {
  const BookPage({
    super.key,
    required this.model,
  });
  final SearchResponseModel model;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Consumer<PxVisits>(
          builder: (context, v, _) {
            if (v.visitResponseModel == null) {
              ///if booking data is null && to prevent errors from non provided navigation
              return const BookingPageErrorCard();
            }
            return IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: context.isMobile ? 10 : 40),
                  Expanded(
                    child: Flex(
                      direction:
                          context.isMobile ? Axis.vertical : Axis.horizontal,
                      children: [
                        Spacer(flex: context.isMobile ? 1 : 100),

                        ///doctor identification card && booking date and time.
                        BookAppInfoCard(
                          doctor: model.doctor,
                          clinic: model.clinic,
                        ),
                        const Gap(30),

                        ///booking form input && submit button
                        const BookAppForm(),
                        Spacer(flex: context.isMobile ? 1 : 100),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const FooterSection(),
      ],
    );
  }
}

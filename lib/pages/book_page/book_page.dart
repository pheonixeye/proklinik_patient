import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/pages/book_page/widgets/book_app_form.dart';
import 'package:patient/pages/book_page/widgets/book_app_info_card.dart';
import 'package:patient/pages/book_page/widgets/page_error_card.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Consumer<PxBooking>(
          builder: (context, b, _) {
            if (b.data == null) {
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
                        const BookAppInfoCard(),
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/models/booking_data.dart';
import 'package:patient/pages/visit_update_page/widgets/booking_info_card.dart';
import 'package:patient/pages/visit_update_page/widgets/confirm_delete_dialog.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/visit_update_px.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:patient/widgets/homepage_btn/homepage_btn.dart';
import 'package:provider/provider.dart';

class VisitUpdatePage extends StatelessWidget {
  const VisitUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxVisitUpdate>(
      builder: (context, l, v, _) {
        final avatarDimensions = context.isMobile ? 70.0 : 125.0;
        while (v.data == null && v.hasError != true) {
          return const CentralLoading();
        }
        if (v.hasError) {
          return Center(
            child: Text(context.loc.visitNotFound),
          );
        }
        if (v.bookingData!.status == Status.cancel_by_patient ||
            v.bookingData!.status == Status.cancel_by_doctor) {
          return Center(
            child: Card.outlined(
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.loc.bookingAlreadyCanceled),
                    const HomepageBtn(),
                  ],
                ),
              ),
            ),
          );
        }
        while (v.showThankYou) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card.outlined(
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FontAwesomeIcons.handsPraying,
                        size: 32,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.loc.thankYouForUsingProklinik,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const HomepageBtn(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return ListView(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.isMobile ? 12 : 36.0,
                vertical: 8,
              ),
              child: Card.outlined(
                color: Colors.white,
                elevation: 2,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: avatarDimensions,
                        height: avatarDimensions,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: v.doctor == null
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(v.doctor!.avatarUrl!),
                                ),
                        ),
                        child: v.doctor == null
                            ? const SizedBox()
                            : const Icon(
                                FontAwesomeIcons.userDoctor,
                                size: 32,
                              ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish ? v.doctor!.name_en : v.doctor!.name_ar,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l.isEnglish
                                ? v.doctor!.title_en
                                : v.doctor!.title_ar,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            BookingInfoCard(
              bookingData: v.bookingData!,
              clinic: v.clinic!,
              doctor: v.doctor!,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    onPressed: () {
                      v.changeState(BookingCardState.schedule);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        context.loc.updateBooking,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: Theme.of(context).appBarTheme.backgroundColor!,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) => const ConfirmDeleteDialog(),
                      );
                      if (result != null && result) {
                        await v.updateBookingData(
                          update: {
                            'attended': false,
                            'status': Status.cancel_by_patient.value,
                          },
                        );
                        v.updateShowThankYou();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        context.loc.deleteBooking,
                        style: TextStyle(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const FooterSection(),
          ],
        );
      },
    );
  }
}

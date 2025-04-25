import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/model_widgets_ext.dart';
import 'package:patient/pages/error_page/error_page.dart';
import 'package:patient/pages/visit_update_page/widgets/booking_info_card.dart';
import 'package:patient/pages/visit_update_page/widgets/confirm_delete_dialog.dart';
import 'package:patient/pages/visit_update_page/widgets/original_booking_info_card.dart';
import 'package:patient/pages/visit_update_page/widgets/thankyou_card.dart';
import 'package:patient/pages/visit_update_page/widgets/visit_already_canceled_card.dart';
import 'package:patient/pages/visit_update_page/widgets/visit_date_passed_card.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/px_app_constants.dart';
import 'package:patient/providers/visit_update_px.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class VisitUpdatePage extends StatelessWidget {
  const VisitUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarDimensions = context.isMobile ? 70.0 : 125.0;
    return Scaffold(
      body: Consumer3<PxLocale, PxAppConstants, PxVisitUpdate>(
        builder: (context, l, a, v, _) {
          while (a.model == null || v.visit == null) {
            return const CentralLoading();
          }

          final _canceledByPatientVisitStatusId = a.model?.visit_status
              .firstWhere((status) => status.name_en == 'canceled by patient')
              .id;

          while (v.hasError) {
            return const ErrorPage();
          }

          while (v.visitDatePassed == true) {
            return const VisitDatePassedCard();
          }

          while (v.visit!.visit_status.id == _canceledByPatientVisitStatusId) {
            return const VisitAlreadyCanceledCard();
          }

          while (v.showThankYou) {
            return const ThankyouCard();
          }
          return ListView(
            cacheExtent: 3000,
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
                        padding: const EdgeInsets.all(8.0),
                        //todo:
                        child: FutureBuilder<ImageProvider<Object>>(
                          future: v.visit?.doctor.widgetImageProvider(),
                          builder: (context, snapshot) {
                            while (!snapshot.hasData) {
                              return Container(
                                width: avatarDimensions,
                                height: avatarDimensions,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Container(
                              width: avatarDimensions,
                              height: avatarDimensions,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: snapshot.data!,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l.isEnglish
                                  ? '${v.visit?.doctor.name_en}'
                                  : '${v.visit?.doctor.name_ar}',
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l.isEnglish
                                  ? '${v.visit?.doctor.title_en}'
                                  : '${v.visit?.doctor.title_ar}',
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
              OriginalBookingInfoCard(
                visit: v.visit!,
              ),
              const SizedBox(height: 10),
              BookingInfoCard(
                visit: v.updatedVisit!,
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
                            color:
                                Theme.of(context).appBarTheme.backgroundColor!,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final result = await showDialog<bool?>(
                          context: context,
                          builder: (context) => const ConfirmDeleteDialog(),
                        );
                        if (result == null) {
                          return;
                        }
                        if (result) {
                          await v.updateVisitStatus(
                            _canceledByPatientVisitStatusId,
                          );
                          v.updateShowThankYou();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          context.loc.deleteBooking,
                          style: TextStyle(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/model_widgets_ext.dart';
import 'package:patient/pages/visit_update_page/widgets/booking_info_card.dart';
import 'package:patient/pages/visit_update_page/widgets/confirm_delete_dialog.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/px_app_constants.dart';
import 'package:patient/providers/visit_update_px.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:patient/widgets/homepage_btn/homepage_btn.dart';
import 'package:proklinik_models/models/booking_status.dart';
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

          // while (v.hasError) {
          //   return Center(
          //     child: Text(context.loc.visitNotFound),
          //   );
          // }

          // while (v.showThankYou) {
          //   return Center(
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Card.outlined(
          //         elevation: 2,
          //         color: Colors.white,
          //         child: Padding(
          //           padding: const EdgeInsets.all(6.0),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               const Icon(
          //                 FontAwesomeIcons.handsPraying,
          //                 size: 32,
          //                 color: Colors.green,
          //               ),
          //               const SizedBox(height: 10),
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text(
          //                       context.loc.thankYouForUsingProklinik,
          //                       textAlign: TextAlign.center,
          //                       style: const TextStyle(
          //                         fontSize: 18,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               const SizedBox(height: 10),
          //               const HomepageBtn(),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   );
          // }
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              BookingInfoCard(
                visit: v.visit!,
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

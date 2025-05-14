import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/models/visit/visit.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class OriginalBookingInfoCard extends StatelessWidget {
  const OriginalBookingInfoCard({super.key, required this.visit});
  final Visit visit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 12 : 36),
      child: Card.outlined(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.calendar_month),
                const SizedBox(width: 10),
                Text(context.loc.bookingInformation),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.person),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: context.isMobile ? 100 : 200,
                          child: Text(context.loc.yourName),
                        ),
                        const SizedBox(width: 10),
                        Text(visit.patient_name),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.edit_calendar_outlined),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: context.isMobile ? 100 : 200,
                          child: Text(context.loc.bookingDate),
                        ),
                        const SizedBox(width: 10),
                        Consumer<PxLocale>(
                          builder: (context, l, _) {
                            return Text(
                              DateFormat(
                                'dd / MM / yyyy',
                                l.locale.languageCode,
                              ).format(visit.visit_date),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.timer),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: context.isMobile ? 100 : 200,
                          child: Text(context.loc.bookingTime),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          TimeOfDay(
                            hour: visit.visit_shift.start_hour,
                            minute: visit.visit_shift.start_minute,
                          ).format(context).toArabicNumber(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

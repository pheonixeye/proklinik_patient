import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/functions/debug_print.dart';
import 'package:proklinik_patient/models/visit/visit.dart';
import 'package:proklinik_patient/pages/visit_update_page/widgets/reschedule_card.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/providers/visit_update_px.dart';
import 'package:provider/provider.dart';

class BookingInfoCard extends StatelessWidget {
  const BookingInfoCard({
    super.key,
    required this.visit,
  });
  final Visit visit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 12 : 36),
      child: Consumer2<PxLocale, PxVisitUpdate>(
        builder: (context, l, v, _) {
          while (v.visit == null) {
            return SizedBox();
          }
          TextStyle? _newBookingDateTextStyle() =>
              v.visit!.visit_date == v.updatedVisit!.visit_date
                  ? null
                  : TextStyle(
                      color: Theme.of(context).primaryColor,
                    );
          TextStyle? _newBookingShiftTextStyle() =>
              v.visit!.visit_shift == v.updatedVisit!.visit_shift
                  ? null
                  : TextStyle(
                      color: Theme.of(context).primaryColor,
                    );
          return Card.outlined(
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return switch (v.state) {
                    BookingCardState.data => ListTile(
                        title: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 10),
                            Text(context.loc.newBookingInformation),
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
                                    const Icon(Icons.edit_calendar_outlined),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: context.isMobile ? 100 : 200,
                                      child: Text(context.loc.bookingDate),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormat(
                                        'dd / MM / yyyy',
                                        l.locale.languageCode,
                                      ).format(visit.visit_date),
                                      style: _newBookingDateTextStyle(),
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
                                      style: _newBookingShiftTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    BookingCardState.schedule => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 280,
                          width: context.isMobile ? null : 400,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 365,
                                  itemBuilder: (context, index) {
                                    return RescheduleCard(
                                      clinic: visit.clinic,
                                      index: index,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    v.changeState(BookingCardState.data);
                                  },
                                  child: Text(context.loc.back),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    BookingCardState.confirm => ListTile(
                        title: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 10),
                            Text(context.loc.newBookingInformation),
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
                                    const Icon(Icons.edit_calendar_outlined),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: context.isMobile ? 100 : 200,
                                      child: Text(context.loc.bookingDate),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormat(
                                        'dd / MM / yyyy',
                                        l.locale.languageCode,
                                      ).format(visit.visit_date),
                                      style: _newBookingDateTextStyle(),
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
                                      style: _newBookingShiftTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          await v.updateVisitBookingData();
                                          v.updateShowThankYou();
                                        } catch (e) {
                                          dprint(e);
                                        }
                                      },
                                      child: Text(
                                          context.loc.confirmUpdateBooking),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  };
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

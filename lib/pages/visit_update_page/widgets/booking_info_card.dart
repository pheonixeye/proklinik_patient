import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/debug_print.dart';
import 'package:patient/pages/visit_update_page/widgets/reschedule_card.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/visit_update_px.dart';
import 'package:proklinik_models/models/booking_data.dart';
import 'package:proklinik_models/models/clinic.dart';
import 'package:proklinik_models/models/doctor.dart';
import 'package:proklinik_models/models/server_response_model.dart';
import 'package:provider/provider.dart';

class BookingInfoCard extends StatefulWidget {
  const BookingInfoCard({
    super.key,
    required this.bookingData,
    required this.clinic,
    required this.doctor,
  });
  final BookingData bookingData;
  final Clinic clinic;
  final Doctor doctor;

  @override
  State<BookingInfoCard> createState() => _BookingInfoCardState();
}

class _BookingInfoCardState extends State<BookingInfoCard> {
  // late BookingData _state;

  @override
  void initState() {
    // _state = widget.bookingData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 12 : 36),
      child: Consumer2<PxLocale, PxVisitUpdate>(
        builder: (context, l, v, _) {
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
                                    Text(v.bookingData!.user_name),
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
                                      child: Text(context.loc.bookingDate),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormat(
                                        'dd/MM/yyyy',
                                        context.loc.localeName,
                                      ).format(
                                        DateTime.parse(
                                          v.bookingData!.date_time,
                                        ),
                                      ),
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
                                      model: ServerResponseModel(
                                        doctor: widget.doctor,
                                        clinic: widget.clinic,
                                        reviews: const [],
                                        total: 1,
                                      ),
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
                                  child: Text(context.loc.cancel),
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
                                    Text(v.bookingData!.user_name),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    const Icon(Icons.calendar_month),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: context.isMobile ? 100 : 200,
                                      child: Text(context.loc.bookingDate),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormat(
                                        'dd/MM/yyyy',
                                        context.loc.localeName,
                                      ).format(
                                        DateTime.parse(
                                          v.newBookingData!.date_time,
                                        ),
                                      ),
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
                                        hour: v.newBookingData!.startH.toInt(),
                                        minute:
                                            v.newBookingData!.startM.toInt(),
                                      ).format(context).toArabicNumber(context),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await v.updateBookingData(
                                          update: v.newBookingData!
                                              .toPocketbaseJson(),
                                        );
                                        v.updateShowThankYou();
                                      } catch (e) {
                                        dprint(e);
                                      }
                                    },
                                    child: Text(context.loc.updateBooking),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      v.changeState(BookingCardState.data);
                                    },
                                    child: Text(context.loc.cancel),
                                  ),
                                ],
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

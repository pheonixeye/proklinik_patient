import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/constants/weekdays.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/am_pm.dart';
import 'package:patient/models/booking_data.dart';
import 'package:patient/models/schedule.dart';
import 'package:patient/models/server_response_model.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

const twoWeeks = <int>[1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7];

class BookRowSm extends StatefulWidget {
  const BookRowSm({
    super.key,
    required this.responseModel,
  });
  final ServerResponseModel responseModel;

  @override
  State<BookRowSm> createState() => _BookRowSmState();
}

class _BookRowSmState extends State<BookRowSm> {
  static final now = DateTime.now();
  DateTime baseDate = DateTime(now.year, now.month, now.day);

  DateTime? firstAvailableDate;
  Schedule? _schedule;
  bool isFirstAvailableDate = false;

  final List<Schedule> _sorted = [];

  @override
  void initState() {
    _sorted.addAll(widget.responseModel.clinic.schedule);

    _sorted.sort((a, b) {
      return a.intday.compareTo(b.intday);
    });
    for (int i = 0; i < 7; i++) {
      final date = DateTime(baseDate.year, baseDate.month, baseDate.day + i);

      try {
        _schedule = _sorted.firstWhere((x) => x.intday == date.weekday);
        firstAvailableDate = date;
        break;
      } catch (e) {
        _schedule = null;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: AppTheme.greyBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //todo: fetch from clinic
                //todo: calculate first available date
                child: Consumer<PxLocale>(
                  builder: (context, l, _) {
                    final time =
                        "${_schedule?.startHour.normalizeHour.toString().toArabicNumber(context)}:${_schedule?.startMin.toString().toArabicNumber(context)} ${_schedule?.startHour.amPm(context)}";
                    String? day;
                    if (firstAvailableDate ==
                        DateTime(now.year, now.month, now.day)) {
                      day = context.loc.today;
                    } else if (firstAvailableDate ==
                        DateTime(now.year, now.month, now.day + 1)) {
                      day = context.loc.tomorrow;
                    } else {
                      day =
                          "${l.isEnglish ? WEEKDAYS[firstAvailableDate?.weekday]?.en : WEEKDAYS[firstAvailableDate?.weekday]?.ar} - ${firstAvailableDate?.day.toString().toArabicNumber(context)}/${firstAvailableDate?.month.toString().toArabicNumber(context)}";
                    }
                    return Text(
                      "${context.loc.available} ${context.loc.from} $day-$time",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: AppTheme.secondaryOrangeColor,
            ),
            onPressed: () {
              //todo: nav to book page
              context
                  .read<PxBooking>()
                  .setBookingData(BookingData.empty().copyWith(
                    id: const Uuid().v4(),
                    model: widget.responseModel,
                    doc_id: widget.responseModel.doctor.id,
                    clinic_id: widget.responseModel.clinic.id,
                    date_time: firstAvailableDate!.toIso8601String(),
                  ));
              GoRouter.of(context).goNamed(
                AppRouter.book,
                pathParameters: defaultPathParameters(context),
              );
            },
            child: Text(
              context.loc.book,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

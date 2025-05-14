import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proklinik_patient/constants/weekdays.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/models/clinic/schedule.dart';
import 'package:proklinik_patient/models/search_response_model/search_response_model.dart';
import 'package:proklinik_patient/models/visit/visit_response_model.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/providers/px_app_constants.dart';
import 'package:proklinik_patient/providers/px_visits.dart';
import 'package:proklinik_patient/router/router.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class BookRowSm extends StatefulWidget {
  const BookRowSm({
    super.key,
    required this.model,
  });
  final SearchResponseModel model;

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
    _sorted.addAll(widget.model.clinic.schedule);

    _sorted.sort((a, b) {
      return a.intday.compareTo(b.intday);
    });
    for (int i = 0; i < 7; i++) {
      final date = DateTime(baseDate.year, baseDate.month, baseDate.day + i);

      try {
        _schedule =
            _sorted.firstWhere((x) => x.intday == date.weekday && x.available);
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
      child: Consumer2<PxAppConstants, PxLocale>(
        builder: (context, a, l, _) {
          while (a.model == null) {
            return const SizedBox();
          }
          final shifts = _schedule!.shifts;
          shifts.sort((a, b) => a.startH.compareTo(b.startH));
          final timeStart = TimeOfDay(
            hour: shifts.first.startH.toInt(),
            minute: shifts.first.startM.toInt(),
          );
          final timeStartString = timeStart.format(context);
          final timeEnd = TimeOfDay(
            hour: shifts.first.endH.toInt(),
            minute: shifts.first.endM.toInt(),
          );
          final shift_id = shifts.first.id;
          String? day;
          if (firstAvailableDate == DateTime(now.year, now.month, now.day)) {
            day = context.loc.today;
          } else if (firstAvailableDate ==
              DateTime(now.year, now.month, now.day + 1)) {
            day = context.loc.tomorrow;
          } else {
            day =
                "${l.isEnglish ? WEEKDAYS[firstAvailableDate?.weekday]?.en : WEEKDAYS[firstAvailableDate?.weekday]?.ar} - ${firstAvailableDate?.day.toString().toArabicNumber(context)}/${firstAvailableDate?.month.toString().toArabicNumber(context)}";
          }
          return Row(
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
                    child: Builder(
                      builder: (context) {
                        return Text(
                          "${context.loc.available} ${context.loc.from} $day - ${timeStartString.toArabicNumber(context)}",
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

                  context.read<PxVisits>().setVisitModel(VisitResponseModel(
                        id: '',
                        visit_date: firstAvailableDate!.toIso8601String(),
                        doc_id: widget.model.doctor.id,
                        clinic_id: widget.model.clinic.id,
                        day: firstAvailableDate!.day,
                        month: firstAvailableDate!.month,
                        year: firstAvailableDate!.year,
                        created: '',
                        visit_shift: {
                          'id': shift_id,
                          'start_hour': timeStart.hour,
                          'start_minute': timeStart.minute,
                          'end_hour': timeEnd.hour,
                          'end_minute': timeEnd.minute,
                        },
                        patient_name: '',
                        patient_phone: '',
                        patient_email: '',
                        patient_id: '',
                        visit_status_id: a.model?.initialVisitStatus.id ?? '',
                        visit_type_id: '',
                      ));
                  GoRouter.of(context).goNamed(
                    AppRouter.book,
                    pathParameters: defaultPathParameters(context),
                    extra: widget.model,
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
          );
        },
      ),
    );
  }
}

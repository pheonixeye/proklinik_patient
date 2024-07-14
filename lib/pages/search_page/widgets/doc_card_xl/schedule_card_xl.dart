import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/constants/now.dart';
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

class ScheduleCardXl extends StatefulWidget {
  const ScheduleCardXl({
    super.key,
    required this.model,
    required this.index,
  });
  final ServerResponseModel model;
  final int index;

  @override
  State<ScheduleCardXl> createState() => _ScheduleCardXlState();
}

class _ScheduleCardXlState extends State<ScheduleCardXl> {
  bool isHovering = false;
  bool isAvailable = true;
  //todo: change model to include available boolean
  //todo: change availability algorhithm

  static final now = DateTime.now();

  late final DateTime today;

  late final DateTime cardDate;

  Schedule? _schedule;

  @override
  void initState() {
    today = DateTime(now.year, now.month, now.day);

    cardDate = today.add(Duration(days: widget.index));
    try {
      _schedule = widget.model.clinic.schedule
          .singleWhere((sch) => sch.intday == cardDate.weekday);
    } catch (e) {
      _schedule = null;
    }

    isAvailable = _schedule != null && _schedule!.available;
    super.initState();
    // if (kDebugMode) {
    //   print(_schedule?.toJson().toString());
    //   print(data.toString());
    //   print(isAvailable.toString());
    // }
  }

  void Function()? get _onTap {
    return isAvailable
        ? () {
            //todo: nav to book app page directly
            context
                .read<PxBooking>()
                .setBookingData(BookingData.empty().copyWith(
                  id: const Uuid().v4(),
                  date_time: cardDate.toIso8601String(),
                  doc_id: widget.model.doctor.id,
                  clinic_id: widget.model.clinic.id,
                  model: widget.model,
                ));
            GoRouter.of(context).goNamed(
              AppRouter.book,
              pathParameters: defaultPathParameters(context),
              //HACK:
              extra: widget.model.doctor,
            );
          }
        : null;
  }

  double get _opacity => !isAvailable
      ? 1.0
      : isHovering
          ? 0.7
          : 1.0;

  //todo: accept clinic schedule object
  @override
  Widget build(BuildContext context) {
    //todo: translate component
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovering = false;
          });
        },
        child: Opacity(
          opacity: _opacity,
          child: InkWell(
            onTap: _onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.green,
                  width: 0.2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? AppTheme.appBarColor
                          : AppTheme.appBarColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Consumer<PxLocale>(
                      builder: (context, l, _) {
                        final wkDay = l.isEnglish
                            ? WEEKDAYS[cardDate.weekday]?.en
                            : WEEKDAYS[cardDate.weekday]?.ar;
                        // ignore: no_leading_underscores_for_local_identifiers
                        final _data = cardDate == NOWDAY
                            ? "${context.loc.today} - $wkDay"
                            : cardDate == NOWDAY.add(const Duration(days: 1))
                                ? "${context.loc.tomorrow} - $wkDay"
                                : "${cardDate.day}/${cardDate.month} - $wkDay"
                                    .toArabicNumber(context);
                        return Text(
                          _data,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 0.2,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: isAvailable
                          ? [
                              Text(
                                "${context.loc.from} ${_schedule?.startHour.normalizeHour.toString().padLeft(1, "0").toArabicNumber(context)}:${_schedule?.startMin.toString().padLeft(1, "0").toArabicNumber(context)} ${_schedule?.startHour.amPm(context)}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.appBarColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${context.loc.to} ${_schedule?.endHour.normalizeHour.toString().padLeft(1, "0").toArabicNumber(context)}:${_schedule?.endMin.toString().padLeft(1, "0").toArabicNumber(context)} ${_schedule?.endHour.amPm(context)}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppTheme.appBarColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ]
                          : [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  context.loc.noAppointments,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppTheme.mainFontColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? AppTheme.secondaryOrangeColor
                          : AppTheme.secondaryOrangeColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: context.loc.book,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
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

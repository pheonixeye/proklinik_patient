import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/constants/now.dart';
import 'package:patient/constants/weekdays.dart';
import 'package:patient/extensions/concat_on_clinic_shift.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/models/clinic/schedule.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class ScheduleCardXl extends StatefulWidget {
  const ScheduleCardXl({
    super.key,
    required this.model,
    required this.index,
  });
  final SearchResponseModel model;
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

    isAvailable = _schedule != null &&
        _schedule!.available &&
        !widget.model.clinic.off_dates.contains(
          cardDate.toIso8601String(),
        );
    _smallCardHoverState = !isAvailable
        ? {}
        : Map.fromEntries(_schedule!.shifts.map((e) => MapEntry(e.id, false)));
    super.initState();
  }

  late final Map<String, bool> _smallCardHoverState;

  void Function()? get _onTap {
    //TODO

    // return isAvailable
    //     ? () {
    //         //todo: nav to book app page directly
    //         if (_schedule?.shifts.length == 1) {
    //           context
    //               .read<PxBooking>()
    //               .setBookingData(BookingData.empty().copyWith(
    //                 date_time: cardDate.toIso8601String(),
    //                 doc_id: widget.model.doctor.id,
    //                 clinic_id: widget.model.clinic.id,
    //                 model: widget.model,
    //                 day: cardDate.day,
    //                 month: cardDate.month,
    //                 year: cardDate.year,
    //                 startH: _schedule?.shifts.first.startH,
    //                 startM: _schedule?.shifts.first.startM,
    //                 endH: _schedule?.shifts.first.endH,
    //                 endM: _schedule?.shifts.first.endM,
    //               ));
    //           GoRouter.of(context).goNamed(
    //             AppRouter.book,
    //             pathParameters: defaultPathParameters(context),
    //             extra: widget.model.doctor,
    //           );
    //         }
    //       }
    //     : null;
  }

  double get _opacity => !isAvailable
      ? 1.0
      : isHovering
          ? 0.7
          : 1.0;
  TextStyle get _shiftTextStyle => TextStyle(
        color: Theme.of(context).appBarTheme.backgroundColor,
        fontSize: 10,
      );

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
                          : AppTheme.appBarColor.withValues(alpha: 0.3),
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
                                : "${cardDate.day.toString().padLeft(1, "0")}/${cardDate.month.toString().padLeft(1, "0")} - $wkDay"
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
                              ..._schedule!.shifts.map(
                                (shift) {
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (event) {
                                      setState(() {
                                        _smallCardHoverState[shift.id] = true;
                                      });
                                    },
                                    onExit: (event) {
                                      setState(() {
                                        _smallCardHoverState[shift.id] = false;
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        //TODO

                                        // context
                                        //     .read<PxBooking>()
                                        //     .setBookingData(
                                        //         BookingData.empty().copyWith(
                                        //       // id: const Uuid().v4(),
                                        //       date_time:
                                        //           cardDate.toIso8601String(),
                                        //       doc_id: widget.model.doctor.id,
                                        //       clinic_id: widget.model.clinic.id,
                                        //       model: widget.model,
                                        //       day: cardDate.day,
                                        //       month: cardDate.month,
                                        //       year: cardDate.year,
                                        //       startH: shift.startH,
                                        //       startM: shift.startM,
                                        //       endH: shift.endH,
                                        //       endM: shift.endM,
                                        //     ));
                                        GoRouter.of(context).goNamed(
                                          AppRouter.book,
                                          pathParameters:
                                              defaultPathParameters(context),
                                          extra: widget.model.doctor,
                                        );
                                      },
                                      child: Card.outlined(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          side: BorderSide(
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .backgroundColor!,
                                            width: 0.2,
                                          ),
                                        ),
                                        elevation:
                                            _smallCardHoverState[shift.id] ==
                                                    true
                                                ? 8
                                                : 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text.rich(
                                            TextSpan(
                                              text: context.loc.from,
                                              style: _shiftTextStyle,
                                              children: [
                                                const TextSpan(text: ' '),
                                                TextSpan(
                                                  text: TimeOfDay(
                                                    hour: shift.startH.toInt(),
                                                    minute:
                                                        shift.startM.toInt(),
                                                  ).format(context),
                                                ),
                                                if (_schedule?.shifts.length ==
                                                    1)
                                                  TextSpan(
                                                    text: '\n',
                                                    children: [
                                                      TextSpan(
                                                          text: context.loc.to),
                                                      const TextSpan(text: ' '),
                                                      TextSpan(
                                                        text: TimeOfDay(
                                                          hour: shift.endH
                                                              .toInt(),
                                                          minute: shift.endM
                                                              .toInt(),
                                                        ).format(context),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
                          : AppTheme.secondaryOrangeColor
                              .withValues(alpha: 0.3),
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

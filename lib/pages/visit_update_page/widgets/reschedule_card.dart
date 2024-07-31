import 'package:flutter/material.dart';
import 'package:patient/constants/now.dart';
import 'package:patient/constants/weekdays.dart';
import 'package:patient/extensions/concat_on_clinic_shift.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/visit_update_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:proklinik_models/models/schedule.dart';
import 'package:proklinik_models/models/server_response_model.dart';
import 'package:provider/provider.dart';

class RescheduleCard extends StatefulWidget {
  const RescheduleCard({
    super.key,
    required this.model,
    required this.index,
  });

  final ServerResponseModel model;
  final int index;

  @override
  State<RescheduleCard> createState() => _RescheduleCardState();
}

class _RescheduleCardState extends State<RescheduleCard> {
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
        : Map.fromEntries(
            _schedule!.shifts.map((e) => MapEntry(e.concat, false)));
    super.initState();
  }

  late final Map<String, bool> _smallCardHoverState;

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
          child: Consumer<PxVisitUpdate>(
            builder: (context, v, _) {
              return InkWell(
                onTap: () {
                  if (_schedule!.shifts.length == 1) {
                    final now = DateTime.now();
                    final d = DateTime(now.year, now.month, now.day);
                    final newDate = d.copyWith(
                      day: d.day + widget.index,
                    );
                    v.setNewBookingDataState(v.newBookingData!.copyWith(
                      date_time: newDate.toIso8601String(),
                      day: newDate.day,
                      month: newDate.month,
                      year: newDate.year,
                      startH: _schedule!.shifts.first.startH,
                      startM: _schedule!.shifts.first.startM,
                      endH: _schedule!.shifts.first.endH,
                      endM: _schedule!.shifts.first.endM,
                    ));
                    v.changeState(BookingCardState.confirm);
                  }
                },
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
                                : cardDate ==
                                        NOWDAY.add(const Duration(days: 1))
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
                                            _smallCardHoverState[shift.concat] =
                                                true;
                                          });
                                        },
                                        onExit: (event) {
                                          setState(() {
                                            _smallCardHoverState[shift.concat] =
                                                false;
                                          });
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            final now = DateTime.now();
                                            final d = DateTime(
                                                now.year, now.month, now.day);
                                            final newDate = d.copyWith(
                                              day: d.day + widget.index,
                                            );
                                            v.setNewBookingDataState(
                                                v.newBookingData!.copyWith(
                                              date_time:
                                                  newDate.toIso8601String(),
                                              day: newDate.day,
                                              month: newDate.month,
                                              year: newDate.year,
                                              startH: shift.startH,
                                              startM: shift.startM,
                                              endH: shift.endH,
                                              endM: shift.endM,
                                            ));
                                            v.changeState(
                                                BookingCardState.confirm);
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
                                            elevation: _smallCardHoverState[
                                                        shift.concat] ==
                                                    true
                                                ? 8
                                                : 0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text.rich(
                                                TextSpan(
                                                  text: context.loc.from,
                                                  style: _shiftTextStyle,
                                                  children: [
                                                    const TextSpan(text: ' '),
                                                    TextSpan(
                                                      text: TimeOfDay(
                                                        hour: shift.startH
                                                            .toInt(),
                                                        minute: shift.startM
                                                            .toInt(),
                                                      ).format(context),
                                                    ),
                                                    if (_schedule
                                                            ?.shifts.length ==
                                                        1)
                                                      TextSpan(
                                                        text: '\n',
                                                        children: [
                                                          TextSpan(
                                                              text: context
                                                                  .loc.to),
                                                          const TextSpan(
                                                              text: ' '),
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
              );
            },
          ),
        ),
      ),
    );
  }
}

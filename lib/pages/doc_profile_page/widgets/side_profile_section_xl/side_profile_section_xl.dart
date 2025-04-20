import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/model_widgets_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/scroll_direction.dart';
import 'package:patient/models/search_response_model/search_response_model.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_info_card_xl.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/schedule_card_xl.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SideProfileSectionXl extends StatefulWidget {
  const SideProfileSectionXl({super.key, required this.model});
  final SearchResponseModel model;

  @override
  State<SideProfileSectionXl> createState() => _SideProfileSectionXlState();
}

class _SideProfileSectionXlState extends State<SideProfileSectionXl> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void scrollNext() => scrollHorizontally(
        controller: _controller,
        direction: HorizontalScrollDirecion.next,
      );
  void scrollPrevious() => scrollHorizontally(
        controller: _controller,
        direction: HorizontalScrollDirecion.previous,
      );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 465,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            ///white upper margin
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.appBarColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        context.loc.bookingInformation,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListTile(
                        title: Text(
                          context.loc.book,
                          style: TextStyle(
                            color: AppTheme.mainFontColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          context.loc.examination,
                          style: TextStyle(
                            color: AppTheme.appBarColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
                    SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: const Icon(
                                Icons.monetization_on,
                                color: Colors.green,
                              ),
                              subtitle: Text.rich(
                                TextSpan(
                                  text: context.loc.fees,
                                  style: TextStyle(
                                    color: AppTheme.mainFontColor,
                                  ),
                                  children: [
                                    const TextSpan(text: " : "),
                                    TextSpan(
                                      text:
                                          "${widget.model.clinic.consultation_fees.toString().toArabicNumber(context)} ${context.loc.pound}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Icon(
                                Icons.timer,
                                color: Colors.green,
                              ),
                              subtitle: Text.rich(
                                TextSpan(
                                  text: context.loc.waitingTime,
                                  style: TextStyle(
                                    color: AppTheme.mainFontColor,
                                  ),
                                  children: [
                                    const TextSpan(text: " : "),
                                    TextSpan(
                                      text:
                                          "${widget.model.clinic_waiting_time.toString().toArabicNumber(context)} ${context.loc.minutes}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
                    SizedBox(
                      height: 80,
                      child: ListTile(
                        leading: const Icon(
                          Icons.pin_drop,
                          color: Colors.green,
                        ),
                        isThreeLine: true,
                        title: Consumer<PxLocale>(
                          builder: (context, l, _) {
                            final area = l.isEnglish
                                ? widget.model.clinic.city.name_en
                                : widget.model.clinic.city.name_ar;

                            final address = l.isEnglish
                                ? widget.model.clinic.address_en
                                : widget.model.clinic.address_ar;

                            return Text(
                              "$area : $address",
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        ),
                        subtitle: Text(
                          context.loc.bookToRecieveInfo,
                          style: TextStyle(
                            color: AppTheme.mainFontColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        context.loc.chooseYourApp,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            IconButton.outlined(
                              onPressed: scrollPrevious,
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const SizedBox(width: 10),

                            ///times cards
                            Expanded(
                              child: ListView.builder(
                                //todo: replace with schedule generator
                                scrollDirection: Axis.horizontal,
                                controller: _controller,
                                itemCount: 365,
                                itemBuilder: (context, index) {
                                  return ScheduleCardXl(
                                    index: index,
                                    model: widget.model,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton.outlined(
                              onPressed: scrollNext,
                              icon: const Icon(Icons.arrow_forward),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Consumer<PxLocale>(
                          builder: (context, l, _) {
                            return Text(
                              widget.model.clinic.attendance_type
                                  .formattedAttendanceType(l.isEnglish),
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
                    SizedBox(
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: ListTile(
                          leading: const Icon(
                            Icons.edit_calendar_outlined,
                            color: Colors.green,
                            size: 48,
                          ),
                          title: Text(context.loc.bookAndPay),
                          subtitle: Text(context.loc.doctorRequiresReservation),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

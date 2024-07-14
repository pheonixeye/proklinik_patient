import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/functions/scroll_direction.dart';
import 'package:patient/functions/stars_from_double.dart';
import 'package:patient/models/server_response_model.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_info_card_xl.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/schedule_card_xl.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class MainInfoCardSm extends StatefulWidget {
  const MainInfoCardSm({super.key, required this.model});
  final ServerResponseModel model;

  @override
  State<MainInfoCardSm> createState() => _MainInfoCardSmState();
}

class _MainInfoCardSmState extends State<MainInfoCardSm> {
  late final ScrollController _controller;
  late final ImageProvider image;

  @override
  void initState() {
    _controller = ScrollController();
    if (widget.model.doctor.avatar == null ||
        widget.model.doctor.avatar!.isEmpty) {
      image = AssetImage(Assets.doctorEmptyAvatar());
    } else {
      image = NetworkImage(widget.model.doctor.avatarUrl!);
    }
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      ///main column layout
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Column(
            children: [
              const SizedBox(height: 10),

              ///main upper card row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),

                  ///avatar
                  Expanded(
                    flex: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  ///info
                  Expanded(
                    flex: 210,
                    child: ExpansionTile(
                      expandedAlignment: l.isEnglish
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      tilePadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      initiallyExpanded: true,
                      title: Text.rich(
                        TextSpan(
                          text: "${context.loc.doctor} ",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.mainFontColor,
                            fontWeight: FontWeight.w300,
                          ),
                          children: [
                            TextSpan(
                              text: l.isEnglish
                                  ? widget.model.doctor.name_en
                                  : widget.model.doctor.name_ar,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.mainFontColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              if (widget.model.doctor.rating == 0)
                                ...5.0.toStars(
                                  size: 18,
                                  padding: const EdgeInsets.all(4),
                                )
                              else
                                ...widget.model.doctor.rating.toStars(
                                  size: 18,
                                  padding: const EdgeInsets.all(4),
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              widget.model.reviews.isNotEmpty
                                  ? Text.rich(
                                      TextSpan(
                                        text:
                                            "${context.loc.overallRating} ${context.loc.from} ${widget.model.reviews.length.toString().toArabicNumber(context)} ${context.loc.visitors}",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            //TODO: Scroll to ratings
                                          },
                                      ),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppTheme.appBarColor,
                                      ),
                                    )
                                  : Text.rich(
                                      TextSpan(
                                        text: context.loc.joinedRecently,
                                      ),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppTheme.appBarColor,
                                      ),
                                    )
                            ],
                          ),
                        ],
                      ),
                      children: [
                        Text(
                          l.isEnglish
                              ? widget.model.doctor.title_en
                              : widget.model.doctor.title_ar,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.mainFontColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              ///booking details section
              const SizedBox(height: 10),
              Divider(
                height: 1,
                thickness: 1,
                color: AppTheme.appBarColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 20),
                  //todo: translate
                  Text(
                    context.loc.doctorBookingDetails,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.mainFontColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                                    "${widget.model.clinic.waiting_time.toString().toArabicNumber(context)} ${context.loc.minutes}",
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
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppTheme.appBarColor,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    context.loc.chooseYourApp,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.mainFontColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 225,
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
                            model: widget.model,
                            index: index,
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
              Divider(
                height: 1,
                thickness: 1,
                color: AppTheme.appBarColor,
              ),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    attendanceFromBool(context, widget.model.clinic.attendance),
                    style: TextStyle(
                      color: AppTheme.mainFontColor,
                    ),
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
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/constants/weekdays.dart';
import 'package:patient/extensions/avatar_url_doctor_ext.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_info_card_xl.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:proklinik_models/models/doctor.dart';
import 'package:provider/provider.dart';

class BookAppInfoCard extends StatefulWidget {
  const BookAppInfoCard({super.key, required this.doctor});
  final Doctor doctor;

  @override
  State<BookAppInfoCard> createState() => _BookAppInfoCardState();
}

class _BookAppInfoCardState extends State<BookAppInfoCard> {
  late final ImageProvider image;

  @override
  void initState() {
    if (widget.doctor.avatar == null) {
      image = AssetImage(Assets.doctorEmptyAvatar());
    } else {
      image = NetworkImage("${widget.doctor.avatarUrl}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //todo: translate component
    //todo: accept booking details

    return Consumer2<PxBooking, PxLocale>(
      builder: (context, b, l, _) {
        while (b.data == null) {
          return const CentralLoading();
        }
        final data = b.data;
        return Expanded(
          flex: context.isMobile ? 245 : 585,
          child: Column(
            children: [
              Expanded(
                flex: context.isMobile ? 1 : 250,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListTile(
                          isThreeLine: true,
                          leading: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: image,
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text.rich(
                              TextSpan(
                                text: "${context.loc.doctor} ",
                                style: TextStyle(
                                  color: AppTheme.mainFontColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: l.isEnglish
                                        ? b.data?.model?.doctor.name_en
                                        : b.data?.model?.doctor.name_ar,
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: AppTheme.mainFontColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              l.isEnglish
                                  ? b.data!.model!.doctor.title_en
                                  : b.data!.model!.doctor.title_ar,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.greyBackgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 36,
                          ),
                          child: Center(
                            child: Builder(
                              builder: (context) {
                                final date = DateTime.parse(b.data!.date_time);
                                final bookingTimeStart = TimeOfDay(
                                  hour: data!.startH.toInt(),
                                  minute: data.startM.toInt(),
                                ).format(context);
                                final bookingTimeEnd = TimeOfDay(
                                  hour: data.endH.toInt(),
                                  minute: data.endM.toInt(),
                                ).format(context);
                                final bookingDate =
                                    DateFormat("dd/MM/yyyy", l.lang);
                                final wkday = l.isEnglish
                                    ? WEEKDAYS[date.weekday]!.en
                                    : WEEKDAYS[date.weekday]!.ar;
                                return Text(
                                    "$wkday - (${bookingDate.format(date)})  - ${bookingTimeStart.toArabicNumber(context)} - ${bookingTimeEnd.toArabicNumber(context)}\n${attendanceFromBool(context, b.data!.model!.clinic.attendance)}");
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              if (!context.isMobile) const Spacer(flex: 300),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/constants/weekdays.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/schedule_to_localized_string.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_info_card_xl.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:provider/provider.dart';

class BookAppInfoCard extends StatelessWidget {
  const BookAppInfoCard({super.key});

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
                          leading: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(Assets.icon),
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
                                  ? b.data!.model!.doctor.speciality_en
                                  : b.data!.model!.doctor.speciality_ar,
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
                                final scheduleList =
                                    data!.model!.clinic.schedule;
                                final date = DateTime.parse(b.data!.date_time);
                                final schedule = scheduleList.firstWhere(
                                    (x) => x.intday == date.weekday);
                                final bookingTime =
                                    schedule.toLocalizedString(context);
                                final bookingDate =
                                    DateFormat("dd/MM/yyyy", l.lang);
                                final wkday = l.isEnglish
                                    ? WEEKDAYS[date.weekday]!.en
                                    : WEEKDAYS[date.weekday]!.ar;
                                return Text(
                                    "$wkday - ${bookingDate.format(date)}  - $bookingTime ,\n ${attendanceFromBool(context, b.data!.model!.clinic.attendance)}");
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

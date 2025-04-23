import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient/constants/weekdays.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/model_widgets_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/models/clinic/clinic.dart';
import 'package:patient/models/doctor/doctor.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/px_app_constants.dart';
import 'package:patient/providers/px_visits.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:provider/provider.dart';

class BookAppInfoCard extends StatelessWidget {
  const BookAppInfoCard({
    super.key,
    required this.doctor,
    required this.clinic,
  });
  final Doctor doctor;
  final Clinic clinic;

  @override
  Widget build(BuildContext context) {
    //todo: translate component
    //todo: accept booking details

    return Consumer3<PxVisits, PxAppConstants, PxLocale>(
      builder: (context, v, a, l, _) {
        while (v.visitResponseModel == null || a.model == null) {
          return const CentralLoading();
        }
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
                          //todo:
                          leading: FutureBuilder<ImageProvider<Object>>(
                            future: doctor.widgetImageProvider(),
                            builder: (context, snapshot) {
                              while (!snapshot.hasData) {
                                return Container(
                                  width: 70,
                                  height: 70,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      padding: EdgeInsets.all(0),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: snapshot.data!,
                                  ),
                                ),
                              );
                            },
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
                                        ? doctor.name_en
                                        : doctor.name_ar,
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
                              l.isEnglish ? doctor.title_en : doctor.title_ar,
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
                                final date = DateTime.parse(
                                    v.visitResponseModel!.visit_date);
                                final bookingTimeStart = TimeOfDay(
                                  hour: v.visitResponseModel
                                      ?.visit_shift['start_hour'],
                                  minute: v.visitResponseModel
                                      ?.visit_shift['start_minute'],
                                ).format(context);
                                final bookingTimeEnd = TimeOfDay(
                                  hour: v.visitResponseModel
                                      ?.visit_shift['end_hour'],
                                  minute: v.visitResponseModel
                                      ?.visit_shift['end_minute'],
                                ).format(context);
                                final bookingDate =
                                    DateFormat("dd / MM / yyyy", l.lang);
                                final wkday = l.isEnglish
                                    ? WEEKDAYS[date.weekday]!.en
                                    : WEEKDAYS[date.weekday]!.ar;
                                return Text(
                                    "$wkday - (${bookingDate.format(date)})  - ${bookingTimeStart.toArabicNumber(context)} - ${bookingTimeEnd.toArabicNumber(context)}\n${clinic.attendance_type.formattedAttendanceType(l.isEnglish)}");
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

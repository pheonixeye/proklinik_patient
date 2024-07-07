import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/models/city.dart';
import 'package:patient/models/governorate.dart';
import 'package:patient/models/search_type.dart';
import 'package:patient/models/speciality.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/spec_gov_px.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class ClinicSearchSection extends StatefulWidget {
  const ClinicSearchSection({super.key});

  @override
  State<ClinicSearchSection> createState() => _ClinicSearchSectionState();
}

class _ClinicSearchSectionState extends State<ClinicSearchSection> {
  final formKey = GlobalKey<FormState>();
  //todo: implement selection
  //todo: navigate to appropriate search page with results

  String? Function(Speciality?)? _specValidator(String message) {
    return (Speciality? value) {
      if (value == null) {
        return message;
      }
      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: AppTheme.searchContainerDecoration,
      child: Consumer2<PxSpecGov, PxLocale>(
        builder: (context, sg, l, _) {
          return Form(
            key: formKey,
            child: Flex(
              direction: context.isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: Card.outlined(
                    elevation: 6,
                    borderOnForeground: false,
                    shape: AppTheme.localizedCardBorder(context, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<Speciality>(
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.green.shade500,
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          validator:
                              _specValidator(context.loc.selectSpecValidator),
                          hint: Text(context.loc.pickSpec),
                          isExpanded: true,
                          items: sg.specialities?.map((e) {
                            return DropdownMenuItem<Speciality>(
                              alignment: Alignment.center,
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (context.isMobile) const Spacer(),
                                  const SizedBox(width: 5),
                                  SvgPicture.asset(
                                    Assets.specialityImage(e.en),
                                    width: 35,
                                    height: 35,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(l.isEnglish ? e.en : e.ar),
                                  if (context.isMobile) const Spacer(),
                                ],
                              ),
                            );
                          }).toList(),
                          value: sg.speciality,
                          onChanged: (val) {
                            if (val != null) {
                              sg.selectSpeciality(val);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card.outlined(
                    elevation: 6,
                    borderOnForeground: false,
                    shape: AppTheme.localizedCardBorder(context, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<Governorate>(
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.green.shade500,
                          ),
                          alignment: Alignment.center,
                          hint: Text(context.loc.pickGov),
                          isExpanded: true,
                          items: sg.governorates?.map((e) {
                            return DropdownMenuItem<Governorate>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(l.isEnglish
                                  ? e.governorate_name_en
                                  : e.governorate_name_ar),
                            );
                          }).toList(),
                          value: sg.governorate,
                          onChanged: (val) {
                            if (val != null) {
                              sg.selectGovernorate(val);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card.outlined(
                    borderOnForeground: false,
                    elevation: 6,
                    shape: AppTheme.localizedCardBorder(context, 2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<City>(
                          hint: Text(context.loc.pickArea),
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.green.shade500,
                          ),
                          alignment: Alignment.center,
                          items: sg.cities?.map((e) {
                            return DropdownMenuItem<City>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(l.isEnglish
                                  ? e.city_name_en
                                  : e.city_name_ar),
                            );
                          }).toList(),
                          value: sg.city,
                          onChanged: (val) {
                            if (val != null) {
                              sg.selectCity(val);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(context.isMobile ? 16 : 0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        shape: context.isMobile
                            ? null
                            : AppTheme.localizedCardBorder(context, 3),
                        fixedSize:
                            context.isMobile ? null : const Size.fromHeight(64),
                        backgroundColor: Colors.green.shade500,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          GoRouter.of(context).goNamed(
                            AppRouter.src,
                            pathParameters: {
                              "lang": l.lang,
                            },

                            ///symbols :
                            ///av => availability
                            ///fe => fees
                            ///lo => location
                            ///so => sort
                            queryParameters: {
                              "type": SearchType.clinic.name,
                              "spec": sg.speciality?.en,
                              "gov": sg.governorate?.governorate_name_en,
                              "city": sg.city?.city_name_en,
                              "page": "1",
                              "av": "any",
                              "fe": "any",
                              "lo": "any",
                              "so": "best-match",
                            },
                          );
                        }
                      },
                      icon: const Icon(Icons.search),
                      label: Text(context.loc.search),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          );
        },
      ),
    );
  }
}

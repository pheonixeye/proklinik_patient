import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/model_widgets_ext.dart';
import 'package:patient/models/app_constants_model/_models/city.dart';
import 'package:patient/models/app_constants_model/_models/governorate.dart';
import 'package:patient/models/app_constants_model/_models/speciality.dart';
import 'package:patient/models/sorting_model/sorting_model.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/px_app_constants.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:proklinik_models/models/search_type.dart';

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

  Speciality? _speciality;
  Governorate? _governorate;
  City? _city;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: AppTheme.searchContainerDecoration,
      child: Consumer2<PxAppConstants, PxLocale>(
        builder: (context, a, l, _) {
          while (a.model == null) {
            return Center(
              child: context.isMobile
                  ? CircularProgressIndicator()
                  : LinearProgressIndicator(),
            );
          }
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
                          items: a.model?.specialities.map((e) {
                            return DropdownMenuItem<Speciality>(
                              alignment: Alignment.center,
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (context.isMobile) const Spacer(),
                                  const SizedBox(width: 5),
                                  SvgPicture.network(
                                    e.svgUrl,
                                    width: 35,
                                    height: 35,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(l.isEnglish ? e.name_en : e.name_ar),
                                  if (context.isMobile) const Spacer(),
                                ],
                              ),
                            );
                          }).toList(),
                          value: _speciality,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _speciality = val;
                              });
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
                          items: a.model?.governorates.map((e) {
                            return DropdownMenuItem<Governorate>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(l.isEnglish ? e.name_en : e.name_ar),
                            );
                          }).toList(),
                          value: _governorate,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _governorate = val;
                                _city = null;
                              });
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
                          items: a.model?.cities
                              .where(
                                  (c) => c.governorate_id == _governorate?.id)
                              .map((e) {
                            return DropdownMenuItem<City>(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(l.isEnglish ? e.name_en : e.name_ar),
                            );
                          }).toList(),
                          value: _city,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _city = val;
                              });
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
                            ///av => availabilityFilter
                            ///fe => fees
                            ///deg => degreeFilter
                            ///so => sort
                            ///lo => locationFilter
                            ///lon => user.lon
                            ///lat => user.lat
                            queryParameters: {
                              "type": SearchType.clinic.name,
                              "spec": _speciality?.id,
                              "gov": _governorate?.id,
                              "city": _city?.id,
                              "page": "1",
                              "av": "any",
                              "fe": "any",
                              "deg": "any",
                              "lo": "any",
                              "lon": '0',
                              "lat": '0',
                              "so": SortingModel.best_match,
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

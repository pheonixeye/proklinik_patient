import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/extensions/number_translator.dart';
import 'package:patient/models/sorting_model/sorting_model.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/px_app_constants.dart';
import 'package:patient/providers/search_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SortingRowXl extends StatelessWidget {
  const SortingRowXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Consumer3<PxSearchController, PxAppConstants, PxLocale>(
        builder: (context, sc, a, l, _) {
          while (a.model == null) {
            return const LinearProgressIndicator();
          }
          final _spec = a.model!.specialities
              .firstWhere((spec) => spec.id == sc.service.query.spec);
          final searchSpec = l.isEnglish ? _spec.name_en : _spec.name_ar;
          return Row(
            children: [
              //todo: search speciality
              Text(
                searchSpec,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mainFontColor,
                ),
              ),
              const SizedBox(width: 10),
              //todo: number of results
              Builder(
                builder: (context) {
                  final _docCount = sc.responseModel == null
                      ? '0'
                      : '${sc.responseModel!.length}';
                  return Text(
                    "(${_docCount.toArabicNumber(context)} ${context.loc.doctor})",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.mainFontColor,
                    ),
                  );
                },
              ),
              const Spacer(flex: 3),
              Text(
                context.loc.sorting,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.mainFontColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 0.1,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    dropdownColor: Colors.white,
                    hint: Text(context.loc.sortBy),
                    elevation: 0,
                    isExpanded: true,
                    alignment: Alignment.center,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      color: Colors.green,
                    ),
                    value: GoRouter.of(context)
                        .routeInformationProvider
                        .value
                        .uri
                        .queryParameters['so'],
                    borderRadius: BorderRadius.circular(8),
                    items: sortingParameters.map((e) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        value: e.value,
                        child: Text(l.isEnglish ? e.en : e.ar),
                      );
                    }).toList(),
                    onChanged: (value) {
                      //todo: implement sorting
                      final currentUri = GoRouter.of(context)
                          .routeInformationProvider
                          .value
                          .uri;
                      final newUri = currentUri.replace(
                        queryParameters: {
                          ...currentUri.queryParameters,
                          'so': value,
                        },
                      );
                      GoRouter.of(context).go(newUri.toString());
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

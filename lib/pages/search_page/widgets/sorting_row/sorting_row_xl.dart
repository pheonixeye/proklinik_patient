import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/search_px.dart';
import 'package:patient/providers/spec_gov_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SortingRowXl extends StatelessWidget {
  const SortingRowXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Consumer3<PxSearchController, PxSpecGov, PxLocale>(
        builder: (context, sc, sg, l, _) {
          while (sg.specialities == null) {
            return const LinearProgressIndicator();
          }
          final searchSpec = l.isEnglish
              ? sc.query.spec
              : sg.specialities!.firstWhere((e) => e.en == sc.query.spec).ar;
          return Row(
            children: [
              //TODO: search speciality
              Text(
                searchSpec,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mainFontColor,
                ),
              ),
              const SizedBox(width: 10),
              //TODO: number of results
              Text(
                "(${ArabicNumbers.convert("${sc.doctors?.length}")} ${context.loc.doctor})",
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.mainFontColor,
                ),
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
                    borderRadius: BorderRadius.circular(8),
                    items: <String, String>{
                      "Best Match": "الاكثر تطابقا",
                      "Price : Low To High": "الاقل سعرا",
                      "Price : High To Low": "الاكثر سعرا",
                      "Waiting Time": "اقل وقت انتظار",
                      "Top Rated": "اعلي التقييمات",
                    }.entries.map((e) {
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        value: e.key,
                        child: Text(l.isEnglish ? e.key : e.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      //TODO: implement sorting
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

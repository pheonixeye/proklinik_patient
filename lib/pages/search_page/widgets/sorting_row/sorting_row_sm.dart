import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/pages/search_page/widgets/filter_column/filter_column_sm.dart';
import 'package:patient/pages/search_page/widgets/sorting_modal.dart/sorting_modal_sm.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/search_px.dart';
import 'package:patient/providers/spec_gov_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SortingRowSm extends StatelessWidget {
  const SortingRowSm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Consumer3<PxSearchController, PxSpecGov, PxLocale>(
          builder: (context, sc, sg, l, _) {
            while (sg.specialities == null) {
              return const LinearProgressIndicator();
            }
            final searchSpec = l.isEnglish
                ? sc.query.spec
                : sg.specialities!.firstWhere((e) => e.en == sc.query.spec).ar;
            return Row(
              children: [
                Text(
                  searchSpec,
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "(${ArabicNumbers.convert("${sc.doctors?.length}")} ${context.loc.doctor})",
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          },
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  //todo: show sort modal
                  Scaffold.of(context).showBottomSheet(
                    (context) {
                      return const SortingModalSm();
                    },
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  );
                },
                label: Text(context.loc.sortBy),
                icon: const Icon(Icons.sort),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  //todo: show filter modal
                  Scaffold.of(context).showBottomSheet(
                    (context) {
                      return const FilterColumnSm();
                    },
                    showDragHandle: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  );
                },
                label: Text(context.loc.filter),
                icon: const Icon(Icons.filter_alt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

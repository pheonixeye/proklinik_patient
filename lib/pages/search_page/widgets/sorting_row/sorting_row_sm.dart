import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/extensions/number_translator.dart';
import 'package:proklinik_patient/pages/search_page/widgets/filter_column/filter_column_sm.dart';
import 'package:proklinik_patient/pages/search_page/widgets/sorting_modal.dart/sorting_modal_sm.dart';
import 'package:proklinik_patient/providers/locale_px.dart';
import 'package:proklinik_patient/providers/px_app_constants.dart';
import 'package:proklinik_patient/providers/search_px.dart';
import 'package:proklinik_patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class SortingRowSm extends StatelessWidget {
  const SortingRowSm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Consumer3<PxSearchController, PxAppConstants, PxLocale>(
          builder: (context, sc, a, l, _) {
            while (a.model == null) {
              return const LinearProgressIndicator();
            }
            final _spec = a.model!.specialities
                .firstWhere((spec) => spec.id == sc.service.query.spec);
            final searchSpec = l.isEnglish ? _spec.name_en : _spec.name_ar;
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
                Builder(
                  builder: (context) {
                    final _docCount = sc.responseModel == null
                        ? '0'
                        : '${sc.responseModel!.length}';
                    return Text(
                      "(${_docCount.toArabicNumber(context)} ${context.loc.doctor})",
                      style: TextStyle(
                        color: AppTheme.mainFontColor,
                        fontSize: 12,
                      ),
                    );
                  },
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

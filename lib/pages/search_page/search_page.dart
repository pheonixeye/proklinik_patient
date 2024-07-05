import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/pages/search_page/pagination_row.dart';
import 'package:patient/pages/search_page/widgets/doc_card_sm/doc_info_card_sm.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_info_card_xl.dart';
import 'package:patient/pages/search_page/widgets/filter_column/filter_column_xl.dart';
import 'package:patient/pages/search_page/widgets/sorting_row/sorting_row_sm.dart';
import 'package:patient/pages/search_page/widgets/sorting_row/sorting_row_xl.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/search_px.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:patient/widgets/central_loading/central_loading.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxSearchController, PxLocale>(
      builder: (context, sc, l, _) {
        while (sc.doctors == null) {
          return const CentralLoading();
        }
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.greyBackgroundColor,
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.isMobile ? 8.0 : 24.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: context.isMobile ? 1 : 100),
                    const FilterColumnXl(),
                    SizedBox(width: context.isMobile ? 0 : 20),
                    Expanded(
                      flex: 950,
                      child: Column(
                        //TODO: generate by iteration
                        children: [
                          //todo: replace according to size
                          context.isMobile
                              ? const SortingRowSm()
                              : const SortingRowXl(),
                          ...List.generate(10, (index) {
                            return context.isMobile
                                ? const DocInfoCardSm()
                                : const DocInfoCardXl();
                          }),
                        ],
                      ),
                    ),
                    Spacer(flex: context.isMobile ? 1 : 100),
                  ],
                ),
              ),
              const PaginationRow(),
              const FooterSection(),
            ],
          ),
        );
      },
    );
  }
}

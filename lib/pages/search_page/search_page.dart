import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_info_card_xl.dart';
import 'package:patient/pages/search_page/widgets/filter_column.dart';
import 'package:patient/pages/search_page/widgets/sorting_row_xl.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:patient/providers/search_px.dart';
import 'package:patient/theme/app_theme.dart';
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
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.greyBackgroundColor,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 100),
                    const FilterColumn(),
                    SizedBox(width: context.isMobile ? 0 : 20),
                    const Expanded(
                      flex: 950,
                      child: Column(
                        children: [
                          SortingRowXl(),
                          //TODO: generate by iteration
                          //TODO: replace according to size
                          DocInfoCardXl(),
                          DocInfoCardXl(),
                          DocInfoCardXl(),
                          DocInfoCardXl(),
                        ],
                      ),
                    ),
                    const Spacer(flex: 100),
                  ],
                ),
              ),
              const FooterSection(),
            ],
          ),
        );
      },
    );
  }
}

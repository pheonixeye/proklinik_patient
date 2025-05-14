import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/pages/search_page/widgets/filter_column/column_filter_items.dart';
import 'package:proklinik_patient/theme/app_theme.dart';

class FilterColumnXl extends StatefulWidget {
  const FilterColumnXl({super.key});

  @override
  State<FilterColumnXl> createState() => _FilterColumnXlState();
}

class _FilterColumnXlState extends State<FilterColumnXl> {
  @override
  Widget build(BuildContext context) {
    //todo: translate component

    if (context.isMobile) {
      return const SizedBox();
    }
    return Expanded(
      flex: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: AppTheme.appBarColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      context.loc.filter,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const FilterColumnItems(),
            ],
          ),
        ),
      ),
    );
  }
}

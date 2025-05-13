import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';
import 'package:proklinik_patient/pages/search_page/widgets/filter_column/column_filter_items.dart';

class FilterColumnSm extends StatefulWidget {
  const FilterColumnSm({super.key});

  @override
  State<FilterColumnSm> createState() => _FilterColumnSmState();
}

class _FilterColumnSmState extends State<FilterColumnSm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height - 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.filter_alt),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                context.loc.filter,
              ),
            ),
            trailing: IconButton.outlined(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          const FilterColumnItems(
            isForMobile: true,
          ),
        ],
      ),
    );
  }
}

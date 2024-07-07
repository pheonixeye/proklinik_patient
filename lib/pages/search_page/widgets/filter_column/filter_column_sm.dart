import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/extensions/loc_ext.dart';

class FilterColumnSm extends StatefulWidget {
  const FilterColumnSm({super.key});

  @override
  State<FilterColumnSm> createState() => _FilterColumnSmState();
}

class _FilterColumnSmState extends State<FilterColumnSm> {
  final TextStyle _filterTitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.green.shade600,
  );
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
          ExpansionTile(
            initiallyExpanded: true,
            title: Row(
              children: [
                const Icon(Icons.calendar_month_outlined),
                const SizedBox(width: 10),
                Text(
                  context.loc.avalability,
                  style: _filterTitleStyle,
                ),
              ],
            ),
            children: [
              CheckboxListTile(
                title: Text(context.loc.anyDate),
                value: true,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
              CheckboxListTile(
                title: Text(context.loc.today),
                value: true,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
              CheckboxListTile(
                title: Text(context.loc.tomorrow),
                value: true,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
            ],
          ),
          const Divider(),
          ExpansionTile(
            initiallyExpanded: true,
            title: Row(
              children: [
                const Icon(FontAwesomeIcons.dollarSign),
                const SizedBox(width: 10),
                Text(
                  context.loc.fees,
                  style: _filterTitleStyle,
                ),
              ],
            ),
            children: [
              RadioListTile(
                title: Text(context.loc.all),
                value: "any",
                groupValue: null,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
              RadioListTile(
                title: Text(context.loc.lessThan300),
                value: "lessThan300",
                groupValue: null,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
              RadioListTile(
                title: Text(context.loc.moreThan300),
                value: "moreThan300",
                groupValue: null,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
            ],
          ),
          const Divider(),
          ExpansionTile(
            initiallyExpanded: true,
            title: Row(
              children: [
                const Icon(Icons.navigation_outlined),
                const SizedBox(width: 10),
                Text(
                  context.loc.location,
                  style: _filterTitleStyle,
                ),
              ],
            ),
            children: [
              RadioListTile(
                title: Text(context.loc.any),
                value: "any",
                groupValue: null,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
              RadioListTile(
                title: Text(context.loc.nearestFirst),
                value: "nearestFirst",
                groupValue: null,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

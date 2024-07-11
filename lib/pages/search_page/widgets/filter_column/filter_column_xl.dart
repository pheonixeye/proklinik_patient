import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/theme/app_theme.dart';

class FilterColumnXl extends StatefulWidget {
  const FilterColumnXl({super.key});

  @override
  State<FilterColumnXl> createState() => _FilterColumnXlState();
}

class _FilterColumnXlState extends State<FilterColumnXl> {
  final TextStyle _filterTitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.green.shade600,
  );

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
              ExpansionTile(
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
                    value: "all",
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
        ),
      ),
    );
  }
}

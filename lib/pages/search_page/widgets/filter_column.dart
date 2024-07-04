import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/theme/app_theme.dart';

class FilterColumn extends StatefulWidget {
  const FilterColumn({super.key});

  @override
  State<FilterColumn> createState() => _FilterColumnState();
}

class _FilterColumnState extends State<FilterColumn> {
  final TextStyle _filterTitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.green.shade600,
  );

  @override
  Widget build(BuildContext context) {
    //TODO: translate component

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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.filter_alt_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              ExpansionTile(
                title: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    const SizedBox(width: 10),
                    Text(
                      "Availability",
                      style: _filterTitleStyle,
                    ),
                  ],
                ),
                children: [
                  CheckboxListTile(
                    title: const Text("Any Date"),
                    value: true,
                    onChanged: (value) {
                      //TODO: implement filtering
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Today"),
                    value: true,
                    onChanged: (value) {
                      //TODO: implement filtering
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Tomorrow"),
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
                      "Fees",
                      style: _filterTitleStyle,
                    ),
                  ],
                ),
                children: [
                  RadioListTile(
                    title: const Text("Any"),
                    value: "any",
                    groupValue: null,
                    onChanged: (value) {
                      //TODO: implement filtering
                    },
                  ),
                  RadioListTile(
                    title: Text("Less Than 300 EGP"),
                    value: "lessThan300",
                    groupValue: null,
                    onChanged: (value) {
                      //TODO: implement filtering
                    },
                  ),
                  RadioListTile(
                    title: Text("More Than 300 EGP"),
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
                      "Location",
                      style: _filterTitleStyle,
                    ),
                  ],
                ),
                children: [
                  RadioListTile(
                    title: const Text("Any"),
                    value: "any",
                    groupValue: null,
                    onChanged: (value) {
                      //TODO: implement filtering
                    },
                  ),
                  RadioListTile(
                    title: Text("Nearest First"),
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

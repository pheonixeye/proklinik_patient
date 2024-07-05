import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Filter By"),
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
            initiallyExpanded: true,
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
                title: const Text("Less Than 300 EGP"),
                value: "lessThan300",
                groupValue: null,
                onChanged: (value) {
                  //TODO: implement filtering
                },
              ),
              RadioListTile(
                title: const Text("More Than 300 EGP"),
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
                title: const Text("Nearest First"),
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

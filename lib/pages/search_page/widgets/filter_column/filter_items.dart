import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/loc_ext.dart';

class FilterItems extends StatefulWidget {
  const FilterItems({super.key, this.isForMobile = false});
  final bool isForMobile;

  @override
  State<FilterItems> createState() => _FilterItemsState();
}

class _FilterItemsState extends State<FilterItems> {
  void _navigateAndFilter(String key, String? value) {
    final currentUri = GoRouter.of(context).routeInformationProvider.value.uri;
    final newUri = currentUri.replace(
      queryParameters: {
        ...currentUri.queryParameters,
        key: value,
      },
    );
    GoRouter.of(context).go(newUri.toString());
    if (widget.isForMobile) {
      Navigator.of(context).pop(true);
    }
  }

  final TextStyle _filterTitleStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.green.shade600,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          initiallyExpanded: widget.isForMobile,
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
            RadioListTile(
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['av'],
              title: Text(context.loc.anyDate),
              value: 'any',
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("av", value);
              },
            ),
            RadioListTile(
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['av'],
              title: Text(context.loc.today),
              value: 'today',
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("av", value);
              },
            ),
            RadioListTile(
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['av'],
              title: Text(context.loc.tomorrow),
              value: 'tomorrow',
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("av", value);
              },
            ),
          ],
        ),
        const Divider(),
        ExpansionTile(
          initiallyExpanded: widget.isForMobile,
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
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['fe'],
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("fe", value);
              },
            ),
            RadioListTile(
              title: Text(context.loc.lessThan300),
              value: "l300",
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['fe'],
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("fe", value);
              },
            ),
            RadioListTile(
              title: Text(context.loc.moreThan300),
              value: "m300",
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['fe'],
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("fe", value);
              },
            ),
          ],
        ),
        const Divider(),
        ExpansionTile(
          initiallyExpanded: widget.isForMobile,
          title: Row(
            children: [
              const Icon(FontAwesomeIcons.userDoctor),
              const SizedBox(width: 10),
              Text(
                context.loc.degree,
                style: _filterTitleStyle,
              ),
            ],
          ),
          children: [
            RadioListTile(
              title: Text(context.loc.all),
              value: "any",
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['deg'],
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("deg", value);
              },
            ),
            RadioListTile(
              title: Text(context.loc.specialist),
              value: "Specialist",
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['deg'],
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("deg", value);
              },
            ),
            RadioListTile(
              title: Text(context.loc.consultant),
              value: "Consultant",
              groupValue: GoRouter.of(context)
                  .routeInformationProvider
                  .value
                  .uri
                  .queryParameters['deg'],
              onChanged: (value) {
                //TODO: implement filtering
                _navigateAndFilter("deg", value);
              },
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

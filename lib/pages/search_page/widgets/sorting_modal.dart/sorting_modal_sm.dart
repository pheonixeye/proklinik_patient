import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/models/sorting_model.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class SortingModalSm extends StatefulWidget {
  const SortingModalSm({super.key});

  @override
  State<SortingModalSm> createState() => _SortingModalSmState();
}

class _SortingModalSmState extends State<SortingModalSm> {
  // ignore: unused_field
  SortingModel? _state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Consumer<PxLocale>(
        builder: (context, l, _) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.sort),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(context.loc.sortBy),
                ),
                trailing: IconButton.outlined(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              ...sortingParameters.map((e) {
                return RadioListTile<String>(
                  title: Text(l.isEnglish ? e.en : e.ar),
                  value: e.value,
                  groupValue: GoRouter.of(context)
                      .routeInformationProvider
                      .value
                      .uri
                      .queryParameters['so'],
                  onChanged: (value) {
                    setState(() {
                      _state = e;
                    });
                    final currentUri =
                        GoRouter.of(context).routeInformationProvider.value.uri;
                    final newUri = currentUri.replace(
                      queryParameters: {
                        ...currentUri.queryParameters,
                        'so': value,
                      },
                    );
                    GoRouter.of(context).go(newUri.toString());
                    //todo: change group value
                    //todo: apply sort filter by GoRoute Navigation
                    Navigator.pop(context, true);
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class SortingModalSm extends StatefulWidget {
  const SortingModalSm({super.key});

  @override
  State<SortingModalSm> createState() => _SortingModalSmState();
}

class _SortingModalSmState extends State<SortingModalSm> {
  String? _state;

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
              ...<String, String>{
                "Best Match": "الاكثر تطابقا",
                "Price : Low To High": "الاقل سعرا",
                "Price : High To Low": "الاكثر سعرا",
                "Waiting Time": "اقل وقت انتظار",
                "Top Rated": "اعلي التقييمات",
              }.entries.map((e) {
                return RadioListTile<String>(
                  title: Text(l.isEnglish ? e.key : e.value),
                  value: e.key,
                  groupValue: _state,
                  onChanged: (value) {
                    setState(() {
                      _state = value;
                    });
                    //TODO: change group value
                    //TODO: apply sort filter by GoRoute Navigation
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

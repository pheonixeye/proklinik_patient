import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.sort),
            title: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sort By"),
            ),
            trailing: IconButton.outlined(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          ...<String>[
            "Best Match",
            "Price : Low To High",
            "Price : High To Low",
            "Waiting Time",
            "Top Rated"
          ].map((e) {
            return RadioListTile<String>(
              title: Text(e),
              value: e,
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
      ),
    );
  }
}

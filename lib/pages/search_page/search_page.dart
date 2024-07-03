import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(context.loc.srcPage),
        ),
      ],
    );
  }
}

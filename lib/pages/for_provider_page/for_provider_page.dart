import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';

class ForProvidersPage extends StatelessWidget {
  const ForProvidersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(context.loc.forProviders),
        ),
      ],
    );
  }
}

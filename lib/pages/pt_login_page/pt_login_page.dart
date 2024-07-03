import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';

class PatientLoginPage extends StatelessWidget {
  const PatientLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(context.loc.login),
        ),
      ],
    );
  }
}

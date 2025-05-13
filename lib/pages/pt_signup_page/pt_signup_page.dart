import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';

class PatientSignUpPage extends StatelessWidget {
  const PatientSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(context.loc.signup),
        ),
      ],
    );
  }
}

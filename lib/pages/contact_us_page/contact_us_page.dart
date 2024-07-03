import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(context.loc.contactUs),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/is_mobile_context.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';

class BookingPageErrorCard extends StatelessWidget {
  const BookingPageErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    //todo: translate component
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 150.0,
        horizontal: context.isMobile ? 5 : 150,
      ),
      child: Card.outlined(
        elevation: 6,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.loc.somethingWentWrong),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(context.loc.errorText),
              ),
              trailing: const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

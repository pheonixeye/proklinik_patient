import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';

class BookingPageErrorCard extends StatelessWidget {
  const BookingPageErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: translate component
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 150.0,
        horizontal: context.isMobile ? 5 : 150,
      ),
      child: const Card.outlined(
        elevation: 6,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Something Went Wrong"),
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "This Page Seems To Be Moved Or Not Available At The Moment, Kindly Try Again Later."),
              ),
              trailing: Icon(
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

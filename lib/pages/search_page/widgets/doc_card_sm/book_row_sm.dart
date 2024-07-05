import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient/providers/booking_px.dart';
import 'package:patient/router/router.dart';
import 'package:patient/theme/app_theme.dart';
import 'package:provider/provider.dart';

class BookRowSm extends StatelessWidget {
  const BookRowSm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: AppTheme.greyBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Available Today From 09:00 P.M.",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: AppTheme.secondaryOrangeColor,
            ),
            onPressed: () {
              //TODO: nav to book page
              context.read<PxBooking>().setBookingData("Booking data");
              GoRouter.of(context).goNamed(
                AppRouter.book,
                pathParameters: defaultPathParameters(context),
              );
            },
            child: const Text(
              "Book",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

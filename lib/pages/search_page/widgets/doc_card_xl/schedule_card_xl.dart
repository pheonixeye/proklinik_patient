import 'package:flutter/material.dart';
import 'package:patient/theme/app_theme.dart';

class ScheduleCardXl extends StatelessWidget {
  const ScheduleCardXl({super.key, this.isAvailable = true});
  final bool isAvailable;

  //TODO: accept clinic schedule object

  @override
  Widget build(BuildContext context) {
    //TODO: translate component
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.green,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                color: isAvailable
                    ? AppTheme.appBarColor
                    : AppTheme.appBarColor.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Today",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: isAvailable
                    ? [
                        Text(
                          "From 07:00 P.M.",
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.appBarColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "To 09:00 P.M.",
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.appBarColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    : [
                        SizedBox(
                          width: 100,
                          child: Text(
                            "No Available Appointments",
                            style: TextStyle(
                              fontSize: 10,
                              color: AppTheme.mainFontColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
              ),
            ),
            Container(
              height: 30,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isAvailable
                    ? AppTheme.secondaryOrangeColor
                    : AppTheme.secondaryOrangeColor.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: const Text(
                "Book",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:patient/theme/app_theme.dart';

class OverallReviewsCardXl extends StatelessWidget {
  const OverallReviewsCardXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 16),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: ListTile(
          isThreeLine: true,
          title: Text(
            "Patient Reviews",
            style: TextStyle(
              color: AppTheme.mainFontColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(
            Icons.star_half,
            color: Colors.green,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          index == 4 ? Icons.star_half : Icons.star,
                          color: Colors.amber,
                          size: 32,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Overall Rating",
                      style: TextStyle(
                        color: AppTheme.mainFontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "4.3 / 5",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "From 124 Visitors",
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

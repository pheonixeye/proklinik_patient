import 'package:flutter/material.dart';
import 'package:patient/theme/app_theme.dart';

class RatingCardXl extends StatelessWidget {
  const RatingCardXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            flex: 470,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///rating text && stars
                ListTile(
                  title: Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Overall Rating"),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Professor of endocrinology, diabetes and internal diseases at Nile Valley and Air Specialized Hospital. - Member of the Egyptian, British and European Endocrinology and Diabetes Societies. Lecturer at Ain Shams University. - Organizing and chairing a medical conference and many medical symposia for diabetes and endocrinology at Wadi El-Nile Hospital – Organizing and presenting educational medical symposia for diabetics at Wadi El-Nile Hospital – Participating in medical conferences for diabetes",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    title: Text(
                      "reviewer name",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.mainFontColor,
                      ),
                    ),
                    subtitle: Text(
                      "Tuesday, 16-05-2024",
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.mainFontColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 215,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///rating blue/green number
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      "4",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Doctor Rating",
                  style: TextStyle(
                    color: AppTheme.mainFontColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

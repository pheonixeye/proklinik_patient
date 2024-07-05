import 'package:flutter/material.dart';
import 'package:patient/theme/app_theme.dart';

class DocDataSmUpper extends StatelessWidget {
  const DocDataSmUpper({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text.rich(
              TextSpan(
                text: "Doctor",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.green.shade500,
                ),
                children: [
                  const TextSpan(text: " "),
                  TextSpan(
                    text: "Kareem Zaher",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              "Urology and Andrology Specialist Surgeon",
              style: TextStyle(
                color: AppTheme.mainFontColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Row(
              children: [
                ...List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              "Overall Rating From 129 Visitors",
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.mainFontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

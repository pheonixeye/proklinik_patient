import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/theme/app_theme.dart';

class MainInfoCardXl extends StatelessWidget {
  const MainInfoCardXl({super.key});

  @override
  Widget build(BuildContext context) {
    ///doctor profile main card
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 235,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///white lateral margin
            const SizedBox(width: 30),

            ///doctor image avatar
            Column(
              children: [
                ///white upper margin
                const SizedBox(height: 15),
                Container(
                  width: 125,
                  height: 125,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(Assets.icon),
                    ),
                  ),
                ),
              ],
            ),

            ///white middle separator
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///white upper margin
                  const SizedBox(width: 15),

                  ///doctor main info title
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Doctor  ",
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: "Mohammed Abd El Razak",
                                  style: TextStyle(
                                    color: AppTheme.mainFontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "1,200 Views",
                            style: TextStyle(
                              color: AppTheme.mainFontColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Professor of General Internal Medicine, Liver, Diseases, Diabetes and Endocrinology - Ain Shams Medicine",
                              style: TextStyle(
                                color: AppTheme.mainFontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///doctor spec && rating summary
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Endocrinology",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.appBarColor,
                          ),
                          children: [
                            const TextSpan(text: " - "),
                            TextSpan(
                              text: "Consultant",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppTheme.mainFontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Row(
                              children: [
                                Icon(
                                  index == 4 ? Icons.star_half : Icons.star,
                                  color: Colors.amber,
                                  size: 32,
                                ),
                                const SizedBox(width: 5),
                              ],
                            );
                          }),
                          const SizedBox(width: 10),
                          Text(
                            "Overall Rating From 461 Visitors",
                            style: TextStyle(
                              color: AppTheme.mainFontColor,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                  text: "Show All Reviews",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      //TODO: Scroll to reviews
                                    }),
                              style: TextStyle(
                                color: AppTheme.appBarColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            ///white lateral margin
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}

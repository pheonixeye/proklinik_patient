import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/theme/app_theme.dart';

class BookAppInfoCard extends StatelessWidget {
  const BookAppInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: context.isMobile ? 245 : 585,
      child: Column(
        children: [
          Expanded(
            flex: context.isMobile ? 1 : 250,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(Assets.icon),
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text.rich(
                          TextSpan(
                            text: "Doctor ",
                            style: TextStyle(
                              color: AppTheme.mainFontColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Kareem Zaher",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppTheme.mainFontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Urology And Andrology Specialist Surgeon.",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.greyBackgroundColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 36,
                      ),
                      child: Center(
                        child: Text(
                            "Tomorrow July (06) - From 12:00 PM To 2:00 PM , Reservation required, first-come, first-served"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (!context.isMobile) const Spacer(flex: 300),
        ],
      ),
    );
  }
}

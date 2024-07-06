import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:patient/assets/assets.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/schedule_card_xl.dart';
import 'package:patient/theme/app_theme.dart';

class MainInfoCardSm extends StatelessWidget {
  const MainInfoCardSm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      ///main column layout
      child: Column(
        children: [
          const SizedBox(height: 10),

          ///main upper card row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),

              ///avatar
              Expanded(
                flex: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.icon,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              ///info
              Expanded(
                flex: 210,
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  initiallyExpanded: true,
                  title: Text.rich(
                    TextSpan(
                      text: "Doctor ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.mainFontColor,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "Mohammed Abd El Razek",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.mainFontColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                index == 4 ? Icons.star_half : Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            );
                          }),
                        ],
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Overall Rating From 461 users",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //TODO: Scroll to ratings
                                },
                            ),
                            style: TextStyle(
                              fontSize: 10,
                              color: AppTheme.appBarColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    Text(
                      "- MD Pediatric and Neonatology. - Pediatric and Neonatology Consultant. - Consultant of Pulmonology, Asthma, Allergy, Immunology and Vaccinology. - Member of Scientific Council of Egyptian board of Pediatric. - Member of American Academy of Pediatric. - Consultant at Police Hospitals. - Consultant at Wadi Elneel Hospital. - Consultant at Air Force Specialized Hospital.",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.mainFontColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          ///booking details section
          const SizedBox(height: 10),
          Divider(
            height: 1,
            thickness: 1,
            color: AppTheme.appBarColor,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Doctor Booking Details",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mainFontColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListTile(
                    title: const Icon(
                      Icons.monetization_on,
                      color: Colors.green,
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        text: "Fees",
                        style: TextStyle(
                          color: AppTheme.mainFontColor,
                        ),
                        children: const [
                          TextSpan(text: " "),
                          TextSpan(
                            text: "700 EGP",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Icon(
                      Icons.timer,
                      color: Colors.green,
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        text: "Waiting Time",
                        style: TextStyle(
                          color: AppTheme.mainFontColor,
                        ),
                        children: const [
                          TextSpan(text: " : "),
                          TextSpan(
                            text: "30 Minutes",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppTheme.appBarColor,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                "Choose Your Appointment",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.mainFontColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 225,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const IconButton.outlined(
                  onPressed: null,
                  icon: Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 10),

                ///times cards
                Expanded(
                  child: ListView(
                    //TODO: replace with schedule generator
                    scrollDirection: Axis.horizontal,
                    // controller: _controller,
                    children: const [
                      ///one times card
                      ScheduleCardXl(
                        isAvailable: false,
                      ),
                      ScheduleCardXl(),
                      ScheduleCardXl(),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const IconButton.outlined(
                  onPressed: null,
                  icon: Icon(Icons.arrow_forward),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppTheme.appBarColor,
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "Reservation required, first-come, first-served",
                style: TextStyle(
                  color: AppTheme.mainFontColor,
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppTheme.appBarColor,
          ),
          const SizedBox(
            height: 75,
            child: ListTile(
              leading: Icon(
                Icons.edit_calendar_outlined,
                color: Colors.green,
                size: 48,
              ),
              title: Text("Book online, Pay at the clinic!"),
              subtitle: Text("Doctor requires reservation!"),
            ),
          ),
        ],
      ),
    );
  }
}

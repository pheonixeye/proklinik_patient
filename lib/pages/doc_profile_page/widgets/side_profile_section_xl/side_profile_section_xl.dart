import 'package:flutter/material.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/schedule_card_xl.dart';
import 'package:patient/theme/app_theme.dart';

class SideProfileSectionXl extends StatelessWidget {
  const SideProfileSectionXl({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 465,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            ///white upper margin
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.appBarColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Booking Information",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListTile(
                        title: Text(
                          "Book",
                          style: TextStyle(
                            color: AppTheme.mainFontColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          "Examination",
                          style: TextStyle(
                            color: AppTheme.appBarColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
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
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
                    SizedBox(
                      height: 80,
                      child: ListTile(
                        leading: const Icon(
                          Icons.pin_drop,
                          color: Colors.green,
                        ),
                        isThreeLine: true,
                        title: Text(
                          "Maadi : Carfour St.",
                          style: TextStyle(
                            color: AppTheme.mainFontColor,
                          ),
                        ),
                        subtitle: Text(
                          "Book now to receive the clinic’s address details and phone number",
                          style: TextStyle(
                            color: AppTheme.mainFontColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppTheme.appBarColor,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Choose Your Appointment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Container(
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 70.0),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

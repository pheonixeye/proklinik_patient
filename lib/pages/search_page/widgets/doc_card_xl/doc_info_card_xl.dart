import 'package:flutter/material.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_data_xl.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/doc_image_xl.dart';
import 'package:patient/pages/search_page/widgets/doc_card_xl/schedule_card_xl.dart';

class DocInfoCardXl extends StatefulWidget {
  const DocInfoCardXl({super.key});

  //TODO: accept doctor info
  //TODO: translate component

  @override
  State<DocInfoCardXl> createState() => _DocInfoCardXlState();
}

class _DocInfoCardXlState extends State<DocInfoCardXl> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          setState(() {
            isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovering = false;
          });
        },
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            color: isHovering ? Colors.green.shade100 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              ///doctor image section
              const DocImageXl(),
              const SizedBox(width: 10),

              ///doctor data section
              const DocDataXl(),
              const SizedBox(width: 10),

              ///Times Section
              ///row => expanded => column
              Expanded(
                flex: 390,
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    ///times cards && navigator
                    Expanded(
                      flex: 22,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          IconButton.outlined(
                            onPressed: () {
                              //TODO: scroll && generate schedule
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(width: 10),

                          ///times cards
                          Expanded(
                            child: ListView(
                              //TODO: replace with schedule generator
                              scrollDirection: Axis.horizontal,
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
                          IconButton.outlined(
                            onPressed: () {
                              //TODO: scroll && generate schedule
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 13,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          //TODO: accept reservation type
                          Text(
                              "Reservation required, first-come, first-served"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

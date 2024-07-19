import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/extensions/loc_ext.dart';
import 'package:patient/pages/homepage/widgets/selector_section/clinic_search.dart';
import 'package:patient/pages/homepage/widgets/selector_section/common_search.dart';
import 'package:patient/pages/homepage/widgets/selector_section/selector_tab.dart';
import 'package:proklinik_models/models/search_type.dart';

class MainAppSelector extends StatefulWidget {
  const MainAppSelector({super.key});

  @override
  State<MainAppSelector> createState() => _MainAppSelectorState();
}

class _MainAppSelectorState extends State<MainAppSelector>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    _controller = TabController(
      length: 4,
      vsync: this,
      initialIndex: _selectedIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 10 : 100),
      child: SizedBox(
        height: context.isMobile ? 500 : 200,
        child: Card.outlined(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: TabBar(
                labelPadding: const EdgeInsets.all(0),
                mouseCursor: SystemMouseCursors.click,
                controller: _controller,
                labelColor: Colors.green.shade700,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  color: Colors.black,
                ),
                indicatorColor: Colors.orange.shade500,
                onTap: (value) {
                  setState(() {
                    _selectedIndex = value;
                  });
                },
                tabs: [
                  SelectorTab(
                    title: context.loc.clinic,
                    iconData: FontAwesomeIcons.houseMedical,
                    selected: _selectedIndex == 0,
                  ),
                  SelectorTab(
                    title: context.loc.lab,
                    iconData: FontAwesomeIcons.fileMedical,
                    selected: _selectedIndex == 1,
                  ),
                  SelectorTab(
                    title: context.loc.rad,
                    iconData: FontAwesomeIcons.laptopMedical,
                    selected: _selectedIndex == 2,
                  ),
                  SelectorTab(
                    title: context.loc.pharma,
                    iconData: FontAwesomeIcons.prescriptionBottleMedical,
                    selected: _selectedIndex == 3,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ClinicSearchSection(),
                CommonSearchSection(
                  type: SearchType.lab,
                ),
                CommonSearchSection(
                  type: SearchType.rad,
                ),
                CommonSearchSection(
                  type: SearchType.pharm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

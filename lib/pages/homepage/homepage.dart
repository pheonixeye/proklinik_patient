import 'package:flutter/material.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/pages/homepage/widgets/main_selector.dart';
import 'package:patient/pages/homepage/widgets/slogan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: context.isMobile ? 30 : 60),
              const Slogan(),
              const MainAppSelector(),
            ],
          ),
        ],
      ),
    );
  }
}

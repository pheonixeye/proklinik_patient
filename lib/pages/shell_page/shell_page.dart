import 'package:flutter/material.dart';
import 'package:patient/extensions/after_layout.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/pages/shell_page/widgets/end_drawer.dart';
import 'package:patient/pages/shell_page/widgets/footer_section/footer_section.dart';
import 'package:patient/pages/shell_page/widgets/language_btn.dart';
import 'package:patient/pages/shell_page/widgets/nav_bar.dart';
import 'package:patient/providers/locale_px.dart';
import 'package:provider/provider.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key, required this.child});
  final Widget child;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    context.read<PxLocale>().setLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          widget.child,
          const FooterSection(),
        ],
      ),
      endDrawer: context.isMobile ? const EndDrawer() : null,
      floatingActionButton: const LanguageBtn(),
    );
  }
}

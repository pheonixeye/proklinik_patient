import 'package:flutter/material.dart';
import 'package:patient/extensions/after_layout.dart';
import 'package:patient/extensions/is_mobile_context.dart';
import 'package:patient/pages/shell_page/widgets/end_drawer.dart';
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
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController(debugLabel: "main-scroll-controller");
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<PxLocale>().setLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      body: widget.child,
      endDrawer: context.isMobile ? const EndDrawer() : null,
      floatingActionButton: context.isMobile ? const LanguageBtn() : null,
    );
  }
}
///
///ListView(
///  controller: _controller,
///  shrinkWrap: true,
///  children: [
///    FutureBuilder<Widget>(
///      future: _buildWidgetChild(),
///      builder: (context, snapshot) {
///        while (!snapshot.hasData || snapshot.data == null) {
///          return const Center(
///            child: CircularProgressIndicator.adaptive(),
///          );
///        }
///        return snapshot.data!;
///      },
///    ),
///    const FooterSection(),
///  ],
///)
///
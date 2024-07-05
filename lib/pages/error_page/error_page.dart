import 'package:flutter/material.dart';
import 'package:patient/pages/book_page/widgets/page_error_card.dart';
import 'package:patient/widgets/footer_section/footer_section.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        BookingPageErrorCard(),
        FooterSection(),
      ],
    );
  }
}

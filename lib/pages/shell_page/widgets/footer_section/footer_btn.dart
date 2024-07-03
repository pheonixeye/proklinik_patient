import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FooterBtn extends StatelessWidget {
  const FooterBtn({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  final TextStyle _style = const TextStyle(
    color: Colors.white,
    fontSize: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        recognizer: TapGestureRecognizer()..onTap = onTap,
        children: const [TextSpan(text: "\n")],
        style: _style,
      ),
    );
  }
}

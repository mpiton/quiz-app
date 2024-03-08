import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {super.key, required this.answerText, required this.onTap});

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: onTap,
          child: Text(unescape.convert(answerText)),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class TextCostum extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color colorText;
  const TextCostum(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: colorText,
      ),
    );
  }
}

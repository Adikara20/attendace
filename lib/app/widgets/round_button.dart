import 'package:flutter/material.dart';

import '../constant/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  final double fontSize;
  final Color color;

  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress,
      required this.fontSize,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: TextStyle(
                        color: AppColors.whiteColor, fontSize: fontSize),
                  )),
      ),
    );
  }
}

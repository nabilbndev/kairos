import 'package:flutter/material.dart';

class KairosTextButton extends StatelessWidget {
  const KairosTextButton(
      {super.key,
      required this.buttonColor,
      required this.buttonBorderColor,
      required this.textColor,
      required this.onTap,
      required this.text});
  final Color buttonColor;
  final Color buttonBorderColor;

  final Color textColor;
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 85, // Adjust as needed
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
              color: buttonColor,
              border: Border.all(color: buttonBorderColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: TextStyle(
                color: textColor, fontSize: 18, fontWeight: FontWeight.w400),
          )),
    );
  }
}

import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.textColor,
      required this.icon,
      required this.iconColor});
  final String text;
  final VoidCallback onTap;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

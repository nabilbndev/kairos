import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.onTap});
  final String imagePath;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onTap: onTap,
      splashColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.2),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            width: 20,
            height: 20,
            imagePath,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          )
        ]),
      ),
    );
  }
}

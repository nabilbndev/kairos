import 'package:flutter/material.dart';

class MoreVerticalCircular extends StatelessWidget {
  const MoreVerticalCircular(
      {super.key, required this.onTap, required this.color});
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black.withOpacity(0.1),
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: color, width: 1.9)),
        child: const Icon(
          Icons.more_vert,
          size: 21,
        ),
      ),
    );
  }
}

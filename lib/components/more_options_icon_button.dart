import 'package:flutter/material.dart';

class MoreOptionsIconButton extends StatelessWidget {
  const MoreOptionsIconButton(
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
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: color, width: 1.9)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DotWidget(color: color),
            DotWidget(color: color),
            DotWidget(color: color)
          ],
        ),
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  const DotWidget({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.8,
      width: 3.8,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
    );
  }
}

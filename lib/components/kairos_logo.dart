import 'package:flutter/material.dart';

class KairosLogo extends StatelessWidget {
  const KairosLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 3.0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: RichText(
            text: const TextSpan(
                style: TextStyle(
                    fontSize: 55,
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
                text: "k",
                children: [
              TextSpan(text: "a", style: TextStyle(fontSize: 50)),
              TextSpan(text: "i", style: TextStyle(fontSize: 45)),
              TextSpan(text: "r", style: TextStyle(fontSize: 45)),
              TextSpan(
                  text: "o",
                  style: TextStyle(
                    fontSize: 50,
                  )),
              TextSpan(text: "S", style: TextStyle(fontSize: 55))
            ])),
      ),
    );
  }
}

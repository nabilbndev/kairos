import 'package:flutter/material.dart';

class AvatarWrapper extends StatelessWidget {
  const AvatarWrapper({
    super.key,
    required this.userPhotoUrl,
  });

  final String? userPhotoUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: SizedBox(
        height: 40,
        width: 40,
        child: userPhotoUrl == null
            ? Image.asset("assets/guest.png")
            : Image.network(userPhotoUrl!),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kairos/components/kairos_avatar_wrapper.dart';
import 'package:kairos/components/more_vert_circular.dart';

class KairosCustomAppBar extends StatelessWidget {
  const KairosCustomAppBar({
    super.key,
    required this.userPhotoUrl,
    required this.userDisplayName,
    required this.userEmail,
  });

  final String? userPhotoUrl;
  final String? userDisplayName;
  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                KairosAvatarWrapper(userPhotoUrl: userPhotoUrl),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userDisplayName == null
                        ? const Text(
                            "Guest's Kairos",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "$userDisplayName's Kairos",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                    userEmail == null
                        ? const Text(
                            "guest@kairos.com",
                            style: TextStyle(fontSize: 12),
                          )
                        : Text(
                            userEmail!,
                            style: const TextStyle(fontSize: 12),
                          )
                  ],
                ),
              ],
            ),
            MoreVerticalCircular(
              color: Colors.black87,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

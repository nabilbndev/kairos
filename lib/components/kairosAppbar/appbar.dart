import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/kairosAppbar/avatar_wrapper.dart';
import 'package:kairos/components/kairosAppbar/outlined_vertical_more_icon.dart';

class KairosAppBar extends StatelessWidget {
  const KairosAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userDisplayName = FirebaseAuth.instance.currentUser?.displayName;
    final userPhotoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AvatarWrapper(userPhotoUrl: userPhotoUrl),
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
                            userEmail,
                            style: const TextStyle(fontSize: 12),
                          )
                  ],
                ),
              ],
            ),
            OutlinedVerticalMoreIcon(
              color: Colors.black87,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
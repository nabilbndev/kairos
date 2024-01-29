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
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Container(
                          height: 8,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .signOut()
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text(
                          "SignOut",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ));
          },
        );
      },
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/kairos_avatar_wrapper.dart';
import 'package:kairos/components/more_vert_circular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDisplayName = FirebaseAuth.instance.currentUser?.displayName;
    final userPhotoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    // var list = ["Cat", "Deer", "Lion", "Tiger"];
    var list = [
      {"name": "Cat", "owner_id": "6O12f738fWQ0NNqP8ITqHGEJsu63"},
      {"name": "Dog", "owner_id": "dsfsdf"}
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              InkWell(
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "$userDisplayName's Kairos",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
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
                      MoreVerticalCircular(
                        color: Colors.black87,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text("Private Notes"),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
                thickness: 0.1,
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 2,
                      color: Colors.black,
                      thickness: 0.1,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                print(userId);
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                            Text(userId != list[index]["owner_id"]
                                ? "Not my task"
                                : "${list[index]["name"]}"),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert)),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.add))
                          ],
                        )
                      ],
                    );
                  },
                  itemCount: list.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Collections {
  Collections(this.name, this.ownerId, this.id);
  final String name;
  final String ownerId;
  final String id;
}

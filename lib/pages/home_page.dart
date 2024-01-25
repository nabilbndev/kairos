import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/kairos_custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDisplayName = FirebaseAuth.instance.currentUser?.displayName;
    final userPhotoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    final userEmail = FirebaseAuth.instance.currentUser?.email;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final TextEditingController collectionNameController =
        TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              KairosCustomAppBar(
                  userPhotoUrl: userPhotoUrl,
                  userDisplayName: userDisplayName,
                  userEmail: userEmail),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Collections"),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Add a new Collection",
                                  textAlign: TextAlign.center),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: collectionNameController,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () async {
                                      await firestore
                                          .collection("collections")
                                          .add({
                                            "collectionName":
                                                collectionNameController.text,
                                            "userId": userId,
                                            "documentId": firestore
                                                .collection("collection")
                                                .doc()
                                                .id
                                          })
                                          .then((value) => {
                                                collectionNameController.clear()
                                              })
                                          .then((value) =>
                                              {Navigator.pop(context)});
                                    },
                                    child: const Text("Add"))
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              const Divider(
                height: 1,
                color: Colors.black,
                thickness: 0.1,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('collections')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Error");
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text("Loading...");
                        default:
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot docu =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                splashColor: Colors.grey,
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(docu["collectionName"]),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.more_vert)),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

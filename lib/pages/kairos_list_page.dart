import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/kairosAppbar/appbar.dart';
import 'package:kairos/components/listPage/add_task_dialog.dart';
import 'package:kairos/components/listPage/kairos_task_tile.dart';

class KairosListPage extends StatelessWidget {
  const KairosListPage({super.key, required this.documentReference});
  final DocumentSnapshot documentReference;
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Stream stream = firestore
        .collection('tasks')
        .where("userId", isEqualTo: userId)
        .where("listId", isEqualTo: documentReference["id"])
        .snapshots();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const KairosAppBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(documentReference["listName"]),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddTaskDialog(
                              listId: documentReference["id"],
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
                    stream: stream,
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
                              DocumentSnapshot taskDocumentReference =
                                  snapshot.data!.docs[index];
                              return KairosTaskTile(
                                  taskDocumentReference: taskDocumentReference);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/TaskPage/add_task_modal.dart';
import 'package:kairos/components/TaskPage/kairos_task_tile.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key, required this.documentReference});
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          documentReference["listName"],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return AddTaskModal(
                      listId: documentReference["id"],
                    );
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Column(
          children: [
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
    );
  }
}

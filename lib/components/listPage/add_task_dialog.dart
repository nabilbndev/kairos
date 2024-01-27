import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key, required this.listId});
  final String listId;
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final TextEditingController taskNameController = TextEditingController();

    addTask() async {
      final taskDocumentReference = firestore.collection("tasks").doc();
      await taskDocumentReference.set({
        "taskName": taskNameController.text,
        "userId": userId,
        "listId": listId,
        "id": taskDocumentReference.id,
      }).then((value) => {taskNameController.clear(), Navigator.pop(context)});
    }

    return AlertDialog(
      title: const Text("Add a new Task", textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: taskNameController,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(onPressed: addTask, child: const Text("Add"))
      ],
    );
  }
}

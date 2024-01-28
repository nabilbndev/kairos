import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTaskDialog extends StatelessWidget {
  const UpdateTaskDialog({
    super.key,
    required this.taskDocumentReference,
  });
  final DocumentSnapshot<Object?> taskDocumentReference;

  @override
  Widget build(BuildContext context) {
    final updateNameController = TextEditingController();
    return AlertDialog(
      title: const Text("Update task Name"),
      content: TextField(
        controller: updateNameController,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              var docId = taskDocumentReference.id;
              FirebaseFirestore.instance
                  .collection("tasks")
                  .doc(docId)
                  .update({"taskName": updateNameController.text}).then(
                      (value) => {
                            updateNameController.clear(),
                            Navigator.pop(context)
                          });
            },
            child: const Text("Update")),
      ],
    );
  }
}

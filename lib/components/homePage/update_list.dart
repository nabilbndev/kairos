import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateListDialog extends StatelessWidget {
  const UpdateListDialog({
    super.key,
    required this.listDocumentReference,
  });
  final DocumentSnapshot<Object?> listDocumentReference;

  @override
  Widget build(BuildContext context) {
    final updateNameController = TextEditingController();
    return AlertDialog(
      title: const Text("Update list Name"),
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
              var docId = listDocumentReference.id;
              FirebaseFirestore.instance
                  .collection("lists")
                  .doc(docId)
                  .update({"listName": updateNameController.text}).then(
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

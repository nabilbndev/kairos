import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddListDialog extends StatelessWidget {
  const AddListDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final TextEditingController listNameController = TextEditingController();
    addList() async {
      final listDocumentReference = firestore
          .collection("lists")
          .doc(); // Create a document reference with a new ID

      await listDocumentReference.set({
        "listName": listNameController.text,
        "userId": userId,
        "id": listDocumentReference
            .id, // Assign the document ID to the "id" field
      }).then((value) => {
            listNameController.clear(),
            Navigator.pop(context)
          }); // Create the document with the specified ID and data
    }

    return AlertDialog(
      title: const Text("Add a new List", textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: listNameController,
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(onPressed: addList, child: const Text("Add"))
      ],
    );
  }
}

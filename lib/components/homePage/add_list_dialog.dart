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
      await firestore
          .collection("lists")
          .add({
            "listName": listNameController.text,
            "userId": userId,
            "documentId": firestore.collection("collection").doc().id
          })
          .then((value) => {listNameController.clear()})
          .then((value) => {Navigator.pop(context)});
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

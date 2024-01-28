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

    return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
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
                    color: Colors.grey.withOpacity(0.5),
                  ),
                )),
            const Divider(
              color: Colors.grey,
              thickness: 0.2,
              height: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors
                              .orange, // Set your desired border color here
                          width: 2.0, // Optionally adjust border width
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                controller: taskNameController,
                autofocus: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    )),
                TextButton(
                    onPressed: () {
                      addTask();
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
              ],
            )
          ],
        ));
  }
}

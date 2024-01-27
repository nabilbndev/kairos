import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KairosTaskTile extends StatelessWidget {
  const KairosTaskTile({
    super.key,
    required this.taskDocumentReference,
  });

  final DocumentSnapshot<Object?> taskDocumentReference;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) {
        //     // ignore: prefer_const_constructors
        //     return KairosListPage(
        //       documentReference: taskDocumentReference,
        //     );
        //   },
        // ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(taskDocumentReference["taskName"]),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateTaskDialog(
                            taskDocumentReference: taskDocumentReference);
                      },
                    );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    var docId = taskDocumentReference.id;
                    await firestore.collection("tasks").doc(docId).delete();
                  },
                  icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}

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

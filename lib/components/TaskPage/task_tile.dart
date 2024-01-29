import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/Common/update_item_modal.dart';

class KairosTaskTile extends StatelessWidget {
  const KairosTaskTile({
    super.key,
    required this.taskDocumentReference,
  });

  final DocumentSnapshot<Object?> taskDocumentReference;

  @override
  Widget build(BuildContext context) {
    final updateTaskController = TextEditingController();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var docId = taskDocumentReference.id;
    updateTask() async {
      await firestore
          .collection("tasks")
          .doc(docId)
          .update({"taskName": updateTaskController.text}).then((value) =>
              {updateTaskController.clear(), Navigator.pop(context)});
    }

    deleteTask() async {
      var docId = taskDocumentReference.id;
      await firestore.collection("tasks").doc(docId).delete();
    }

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
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return UpdateItemModal(
                            title: "Update task",
                            textController: updateTaskController,
                            onTap: updateTask);
                      },
                    );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(onPressed: deleteTask, icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}

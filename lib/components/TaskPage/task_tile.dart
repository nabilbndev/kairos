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
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.2, color: Colors.grey)),
        ),
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
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Container(
                                    height: 8,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return UpdateItemModal(
                                            title: "Rename Task",
                                            textController:
                                                updateTaskController,
                                            onTap: updateTask);
                                      },
                                    );
                                  },
                                  child: const Text("Rename")),
                              TextButton(
                                  onPressed: () {
                                    deleteTask().then(
                                        (value) => Navigator.pop(context));
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ))
                            ],
                          ));
                    },
                  );
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
      ),
    );
  }
}

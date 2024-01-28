import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/listPage/update_task_modal.dart';

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
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return UpdateTaskModal(
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

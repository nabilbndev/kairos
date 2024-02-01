import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/Common/action_button.dart';
import 'package:kairos/components/Common/task_status_popup.dart';
import 'package:kairos/components/Common/update_item_modal.dart';

class KairosTaskTile extends StatefulWidget {
  const KairosTaskTile({
    super.key,
    required this.taskDocumentReference,
  });

  final DocumentSnapshot<Object?> taskDocumentReference;

  @override
  State<KairosTaskTile> createState() => _KairosTaskTileState();
}

class _KairosTaskTileState extends State<KairosTaskTile> {
  @override
  Widget build(BuildContext context) {
    final updateTaskController = TextEditingController(
        text: "${widget.taskDocumentReference["taskName"]}");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var docId = widget.taskDocumentReference.id;
    updateTask() async {
      await firestore
          .collection("tasks")
          .doc(docId)
          .update({"taskName": updateTaskController.text}).then((value) =>
              {updateTaskController.clear(), Navigator.pop(context)});
    }

    deleteTask() async {
      var docId = widget.taskDocumentReference.id;
      await firestore.collection("tasks").doc(docId).delete();
    }

    final taskStatus = widget.taskDocumentReference["taskStatus"];

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
                PopupMenuExample(
                  documentReference: widget.taskDocumentReference,
                ),
                Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    child: taskStatus == "TaskStatus.done"
                        ? const Text(
                            'Done',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          )
                        : taskStatus == "TaskStatus.inprogress"
                            ? const Text(
                                'In Progress',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              )
                            : const Text(
                                'Todo',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              )),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(widget.taskDocumentReference["taskName"]),
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
                          height: MediaQuery.of(context).size.height * 0.3,
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
                              ActionButton(
                                text: "Rename",
                                textColor: Colors.black,
                                icon: Icons.edit,
                                iconColor: Colors.black,
                                onTap: () async {
                                  Navigator.pop(context);
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return UpdateItemModal(
                                          title: "Rename Task",
                                          textController: updateTaskController,
                                          onTap: updateTask);
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ActionButton(
                                  text: "Delete",
                                  icon: Icons.delete_outline_sharp,
                                  iconColor: Colors.red,
                                  onTap: () {
                                    deleteTask().then(
                                        (value) => Navigator.pop(context));
                                  },
                                  textColor: Colors.red),
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

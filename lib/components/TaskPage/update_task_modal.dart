import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/Common/kairos_text_button.dart';

class UpdateTaskModal extends StatefulWidget {
  const UpdateTaskModal({
    super.key,
    required this.taskDocumentReference,
  });
  final DocumentSnapshot<Object?> taskDocumentReference;

  @override
  State<UpdateTaskModal> createState() => _UpdateTaskModalState();
}

class _UpdateTaskModalState extends State<UpdateTaskModal> {
  final updateNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var docId = widget.taskDocumentReference.id;

    updateTask() {
      FirebaseFirestore.instance
          .collection("tasks")
          .doc(docId)
          .update({"taskName": updateNameController.text}).then((value) =>
              {updateNameController.clear(), Navigator.pop(context)});
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
                    color: Colors.grey.withOpacity(0.3),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Update task name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.5),
                          width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder()),
                controller: updateNameController,
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  KairosTextButton(
                      buttonColor: Colors.white,
                      buttonBorderColor: Colors.grey.withOpacity(0.5),
                      textColor: Colors.red,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: "Cancel"),
                  const SizedBox(
                    width: 10,
                  ),
                  KairosTextButton(
                      buttonColor: Colors.black,
                      buttonBorderColor: Colors.black,
                      textColor: Colors.white,
                      onTap: updateTask,
                      text: "Update")
                ],
              ),
            )
          ],
        ));
  }
}

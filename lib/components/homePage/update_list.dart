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
    var docId = listDocumentReference.id;
    final updateNameController = TextEditingController();

    updateList() {
      FirebaseFirestore.instance
          .collection("lists")
          .doc(docId)
          .update({"listName": updateNameController.text}).then((value) =>
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
                "Update list name",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
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
                      updateList();
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
              ],
            )
          ],
        ));
  }
}

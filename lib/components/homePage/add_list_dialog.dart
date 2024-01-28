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
                controller: listNameController,
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
                      addList();
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
    // return AlertDialog(
    //   title: const Text("Add a new List", textAlign: TextAlign.center),
    //   content: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       TextField(
    //         controller: listNameController,
    //       ),
    //     ],
    //   ),
    //   actions: [
    //     TextButton(
    //         onPressed: () {
    //           
    //         },
    //         child: const Text("Cancel")),
    //     TextButton(onPressed: addList, child: const Text("Add"))
    //   ],
    // );
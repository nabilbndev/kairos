import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/pages/kairos_list_page.dart';

class KairosListTile extends StatelessWidget {
  const KairosListTile({
    super.key,
    required this.listDocumentReference,
  });

  final DocumentSnapshot<Object?> listDocumentReference;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            // ignore: prefer_const_constructors
            return KairosListPage(
              documentReference: listDocumentReference,
            );
          },
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(listDocumentReference["listName"]),
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
                        return UpdateListDialog(
                            listDocumentReference: listDocumentReference);
                      },
                    );
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    var docId = listDocumentReference.id;
                    firestore
                        .collection("lists")
                        .doc(docId)
                        .delete()
                        .then((_) => {
                              firestore
                                  .collection("tasks")
                                  .where("listId", isEqualTo: docId)
                                  .get()
                                  .then((snapshot) => {
                                        // ignore: avoid_function_literals_in_foreach_calls
                                        snapshot.docs.forEach((doc) async {
                                          await doc.reference.delete();
                                        })
                                      })
                            });
                  },
                  icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}

class UpdateListDialog extends StatelessWidget {
  const UpdateListDialog({
    super.key,
    required this.listDocumentReference,
  });
  final DocumentSnapshot<Object?> listDocumentReference;

  @override
  Widget build(BuildContext context) {
    final updateNameController = TextEditingController();
    return AlertDialog(
      title: Text("Update list Name"),
      content: TextField(
        controller: updateNameController,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        TextButton(
            onPressed: () {
              var docId = listDocumentReference.id;
              FirebaseFirestore.instance
                  .collection("lists")
                  .doc(docId)
                  .update({"listName": updateNameController.text}).then(
                      (value) => {
                            updateNameController.clear(),
                            Navigator.pop(context)
                          });
            },
            child: Text("Update")),
      ],
    );
  }
}

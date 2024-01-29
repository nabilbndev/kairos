import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/Common/update_item_modal.dart';
import 'package:kairos/pages/task_page.dart';

class KairosListTile extends StatelessWidget {
  const KairosListTile({
    super.key,
    required this.listDocumentReference,
  });

  final DocumentSnapshot<Object?> listDocumentReference;

  @override
  Widget build(BuildContext context) {
    final updateNameController = TextEditingController();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var docId = listDocumentReference.id;

    updateList() async {
      await firestore
          .collection("lists")
          .doc(docId)
          .update({"listName": updateNameController.text}).then((value) =>
              {updateNameController.clear(), Navigator.pop(context)});
    }

    deleteList() async {
      await firestore.collection("lists").doc(docId).delete().then((_) => {
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
    }

    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            // ignore: prefer_const_constructors
            return TaskPage(
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
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return UpdateItemModal(
                            title: "Update list",
                            textController: updateNameController,
                            onTap: updateList);
                      },
                    );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(onPressed: deleteList, icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
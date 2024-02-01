import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/Common/action_button.dart';
import 'package:kairos/components/Common/update_item_modal.dart';
import 'package:kairos/pages/task_page.dart';

class KairosListTile extends StatefulWidget {
  const KairosListTile({
    super.key,
    required this.listDocumentReference,
  });

  final DocumentSnapshot<Object?> listDocumentReference;

  @override
  State<KairosListTile> createState() => _KairosListTileState();
}

class _KairosListTileState extends State<KairosListTile> {
  @override
  Widget build(BuildContext context) {
    final updateNameController = TextEditingController(
        text: "${widget.listDocumentReference["listName"]}");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var docId = widget.listDocumentReference.id;

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

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              // ignore: prefer_const_constructors
              return TaskPage(
                documentReference: widget.listDocumentReference,
              );
            },
          ));
        },
        child: Card(
          elevation: 0.2,
          color: Colors.grey.shade200,
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    widget.listDocumentReference["listName"],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 15),
                                      child: Container(
                                        height: 8,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //
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
                                              title: "Rename List",
                                              textController:
                                                  updateNameController,
                                              onTap: updateList);
                                        },
                                      );
                                    },
                                  ),
                                  //
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ActionButton(
                                      text: "Delete",
                                      icon: Icons.delete_outline_sharp,
                                      iconColor: Colors.red,
                                      onTap: () {
                                        deleteList().then(
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
        ),
      ),
    );
  }
}

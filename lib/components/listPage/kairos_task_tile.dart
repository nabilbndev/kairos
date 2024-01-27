import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          )
        ],
      ),
    );
  }
}

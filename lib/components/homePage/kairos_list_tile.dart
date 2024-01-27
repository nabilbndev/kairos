import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/pages/kairos_list_page.dart';

class KairosListTile extends StatelessWidget {
  const KairosListTile({
    super.key,
    required this.docRef,
  });

  final DocumentSnapshot<Object?> docRef;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            // ignore: prefer_const_constructors
            return KairosListPage(
              documentReference: docRef,
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
                child: Text(docRef["listName"]),
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

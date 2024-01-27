import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/homePage/add_list_dialog.dart';
import 'package:kairos/components/kairosAppbar/appbar.dart';

class KairosListPage extends StatelessWidget {
  const KairosListPage({super.key, required this.documentReference});
  final DocumentSnapshot documentReference;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const KairosAppBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(documentReference["listName"]),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AddListDialog();
                          },
                        );
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              const Divider(
                height: 1,
                color: Colors.black,
                thickness: 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kairos/components/homePage/add_list_dialog.dart';
import 'package:kairos/components/homePage/kairos_list_tile.dart';
import 'package:kairos/components/kairosAppbar/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Stream stream = firestore
        .collection('lists')
        .where("userId", isEqualTo: userId)
        .snapshots();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const KairosAppBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Lists"),
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
              Expanded(
                child: StreamBuilder(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text("Error");
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text("Loading...");
                        default:
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot docRef =
                                  snapshot.data!.docs[index];
                              return KairosListTile(docRef: docRef);
                            },
                          );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

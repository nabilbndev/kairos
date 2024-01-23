import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}

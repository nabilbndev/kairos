import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kairos/pages/list_page.dart';
import 'package:kairos/pages/login_page.dart';

class AuthFlow extends StatelessWidget {
  const AuthFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ListPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}

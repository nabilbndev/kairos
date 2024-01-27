import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kairos/components/login/kairos_logo.dart';
import 'package:kairos/components/login/oauth_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double defaultWidth = 384;
    double containerSize = deviceWidth <= defaultWidth ? 320 : defaultWidth;
    return Center(
      child: SizedBox(
        width: containerSize,
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to Kairos!👋",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                const KairosLogo(),
                const SizedBox(
                  height: 30,
                ),
                SocialAuthButton(
                    onTap: () {},
                    text: "Continue with Microsoft",
                    imagePath: "assets/microsoft_logo.png"),
                const SizedBox(
                  height: 10,
                ),
                SocialAuthButton(
                  onTap: () {
                    signInWithGoogle();
                  },
                  text: "Continue with Google",
                  imagePath: "assets/google_logo.png",
                ),
                const SizedBox(
                  height: 10,
                ),
                const SocialAuthButton(
                    imagePath: "assets/guest.png",
                    text: "Continue as guest",
                    onTap: guestSignIn)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

guestSignIn() async {
  await FirebaseAuth.instance.signInAnonymously();
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

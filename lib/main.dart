import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kairos/auth_flow.dart';
import 'package:kairos/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const KairosApp());
}

class KairosApp extends StatelessWidget {
  const KairosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kairos App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AuthFlow(),
    );
  }
}

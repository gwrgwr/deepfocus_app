import 'package:deepfocus/ui/auth/pages/login_page.dart';
import 'package:deepfocus/ui/auth/widgets/auth_page_view.dart';
import 'package:deepfocus/ui/home/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends StatelessWidget {
  AuthController({super.key});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: firebaseAuth.authStateChanges(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        final User? user = snapshot.data;
        if (user == null) {
          return AuthPageView();
        } else {
          return HomePage();
        }
      } else {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
    });
  }
}
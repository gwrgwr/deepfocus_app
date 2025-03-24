import 'package:deepfocus/ui/auth/auth_viewmodel.dart';
import 'package:deepfocus/ui/auth/pages/auth_page_view.dart';
import 'package:deepfocus/ui/home/pages/home_page.dart';
import 'package:deepfocus/ui/onboarding/pages/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends StatefulWidget {
  const AuthController({super.key});

  @override
  State<AuthController> createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return AuthPageView();
          } else {
            Future.delayed(const Duration(seconds: 3));
            authViewModel.getUserFromMongo.execute();
            return ListenableBuilder(
              listenable: authViewModel.getUserFromMongo,
              builder: (context, child) {
                if (authViewModel.getUserFromMongo.running) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (authViewModel.getUserFromMongo.completed) {
                  if (authViewModel.userMongo != null) {
                    if (authViewModel.userMongo!.firstTime) {
                      return OnboardingPage();
                    }
                    return HomePage();
                  }
                  return const Center(child: CircularProgressIndicator());
                }
                return Scaffold(
                  body: Center(
                    child: Text("An error occurred ${authViewModel.exception}"),
                  ),
                  floatingActionButton: FloatingActionButton(onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  }, child: const Icon(Icons.logout)),
                );
              },
            );
          }
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

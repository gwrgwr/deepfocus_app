import 'package:deepfocus/ui/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authViewModel = AuthViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authViewModel.signOut.execute();
        },
      ),
    );
  }
}

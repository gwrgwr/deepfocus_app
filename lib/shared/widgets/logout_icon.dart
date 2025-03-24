import 'package:deepfocus/ui/auth/widgets/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutIcon extends StatelessWidget {
  LogoutIcon({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _auth.signOut();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AuthController()),
          (route) => false,
        );
      },
      icon: Transform.flip(flipX: true, child: Icon(Icons.logout)),
    );
  }
}

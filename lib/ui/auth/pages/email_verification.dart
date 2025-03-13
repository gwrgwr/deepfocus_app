import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({required this.userCredential, super.key});

  final UserCredential? userCredential;

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  
  @override
  void initState() {
    widget.userCredential?.user?.sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Email Verification',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'A verification email has been sent to your email address. Please verify your email address to continue.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Resend Verification Email'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text('Sign Out')),
            ],
          ),
        ),
      ),
    );
  }
}

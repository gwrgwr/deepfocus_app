import 'package:deepfocus/ui/auth/pages/login_page.dart';
import 'package:deepfocus/ui/auth/pages/register_page.dart';
import 'package:deepfocus/ui/auth/pages/reset_password.dart';
import 'package:flutter/material.dart';

class AuthPageView extends StatelessWidget {
  AuthPageView({super.key});

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        LoginPage(pageController: pageController),
        RegisterPage(pageController: pageController),
        ResetPassword(pageController: pageController),
      ],
    );
  }
}

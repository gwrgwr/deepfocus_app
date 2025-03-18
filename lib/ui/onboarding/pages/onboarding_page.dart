import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
      ),
    );
  }
}
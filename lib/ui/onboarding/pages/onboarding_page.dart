import 'package:deepfocus/shared/widgets/theme_button.dart';
import 'package:deepfocus/ui/auth/auth_viewmodel.dart';
import 'package:deepfocus/ui/home/pages/home_page.dart';
import 'package:deepfocus/ui/onboarding/pages/first_onboarding.dart';
import 'package:deepfocus/ui/onboarding/pages/second_onboarding.dart';
import 'package:deepfocus/ui/onboarding/pages/third_onboarding.dart';
import 'package:deepfocus/ui/onboarding/widgets/my_linear_progress_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  final AuthViewModel authViewModel = AuthViewModel();

  final List<Widget> _pages = [
    FirstOnboarding(),
    SecondOnboarding(),
    ThirdOnboarding(),
  ];

  int _currentPage = 0;

  bool _isOutOfBound() {
    return _currentPage >= _pages.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DeepFocus"),
        leading: IconButton(
          onPressed: () => authViewModel.signOut.execute(),
          icon: Transform.flip(flipX: true, child: Icon(Icons.logout)),
        ),
        actions: [ThemeButton()],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Row(
            spacing: 1,
            children: List.generate(_pages.length, (index) {
              return Expanded(
                child: MyLinearProgressIndicator(
                  value: index == _currentPage ? 1 : 0,
                ),
              );
            }),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isOutOfBound()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            setState(() {
              _currentPage++;
            });
            _pageController.animateToPage(
              _currentPage,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        },
        child: Icon(_isOutOfBound() ? Icons.check : Icons.arrow_forward),
      ),
    );
  }
}

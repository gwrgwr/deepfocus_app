import 'package:deepfocus/shared/widgets/filled_expandend_button.dart';
import 'package:deepfocus/shared/widgets/theme_button.dart';
import 'package:deepfocus/ui/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({required this.pageController, super.key});

  final PageController pageController;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailTextController = TextEditingController();

  final AuthViewModel _authViewModel = AuthViewModel();

  @override
  void initState() {
    _authViewModel.sendEmailResetPassword.addListener(_listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            widget.pageController.jumpToPage(0);
          },
          icon: Icon(Icons.keyboard_arrow_left_sharp),
        ),
        actions: [ThemeButton()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Image.asset("assets/password.png"),
              Text(
                "Reset Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Enter your email address and we'll send you a link to reset your password",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: emailTextController,
                decoration: InputDecoration(
                  hintText: "your@email.com",
                  border: OutlineInputBorder(),
                ),
              ),
              FilledExpandendButton(
                onPressed:
                    _authViewModel.sendEmailResetPassword.running
                        ? null
                        : () {
                          _authViewModel.sendEmailResetPassword.execute(
                            emailTextController.text.trim(),
                          );
                        },
                text: "SEND EMAIL",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listener() {
    if (_authViewModel.sendEmailResetPassword.completed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email sent to ${emailTextController.text.trim()}"),
        ),
      );
    }
    if (_authViewModel.sendEmailResetPassword.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred ${_authViewModel.exception}"),
        ),
      );
    }
  }
}

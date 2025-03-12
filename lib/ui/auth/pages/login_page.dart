import 'package:deepfocus/ui/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({required this.pageController, super.key});

  final PageController pageController;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final authViewModel = AuthViewmodel();

  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Image.asset("assets/focus_illustration.png", scale: 3),
                  Text(
                    "Welcome to DeepFocus",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "Keep your focus and stay productive",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    spacing: 15,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          suffixText: ".com",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        obscureText: isPasswordVisible,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "********",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon:
                                isPasswordVisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot password?"),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      authViewModel.loginUser.execute(
                        (emailController.text, passwordController.text),
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("LOGIN", style: TextStyle(letterSpacing: 2)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.black),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(thickness: 1, color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF4285F4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset("assets/google.png", scale: 2),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Sign In with Google",
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF333333),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset("assets/github.png", scale: 2),
                        ),
                        Expanded(
                          child: Text(
                            "Sign in with Github",
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () async {
                          await widget.pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Text("Register"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

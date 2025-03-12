import 'package:deepfocus/ui/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({required this.pageController, super.key});

  final PageController pageController;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final authViewModel = AuthViewmodel();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;

  bool rememberMe = false;

  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;
  bool hasMinLength = false;

  void checkPassword(String value) {
    setState(() {
      hasUppercase = value.contains(RegExp(r'[A-Z]')); // Letra maiúscula
      hasNumber = value.contains(RegExp(r'[0-9]')); // Número
      hasSpecialChar = value.contains(
        RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
      ); // Caractere especial
      hasMinLength = value.length >= 8; // Pelo menos 8 caracteres
    });
  }

  Widget buildRequirement(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

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
                  Text(
                    "Create an Account",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 30),
                  Column(
                    spacing: 15,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Enter your name",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                        ),
                      ),
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
                        onChanged: checkPassword,
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
                      buildRequirement("At least 8 characters", hasMinLength),
                      buildRequirement(
                        "At least one uppercase letter",
                        hasUppercase,
                      ),
                      buildRequirement("At least one number", hasNumber),
                      buildRequirement(
                        "At least one special character",
                        hasSpecialChar,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  FilledButton(
                    onPressed: () {
                      authViewModel.registerUser.execute(
                        (emailController.text, passwordController.text),
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("REGISTER", style: TextStyle(letterSpacing: 2)),
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
                            "Sign up with Google",
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
                            "Sign up with Github",
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
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(onPressed: () {}, child: Text("Login")),
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

import 'package:deepfocus/shared/widgets/logout_icon.dart';
import 'package:deepfocus/ui/auth/auth_viewmodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: LogoutIcon(),
    );
  }
}

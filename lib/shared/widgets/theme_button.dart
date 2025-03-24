import 'package:deepfocus/utils/theme_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            value.toggleTheme();
          },
          icon: Icon(
            value.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
          ),
        );
      },
    );
  }
}

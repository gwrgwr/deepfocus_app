import 'package:flutter/material.dart';

class OnboardingOption extends StatefulWidget {
  const OnboardingOption({required this.text, super.key});

  final String text;

  @override
  State<OnboardingOption> createState() => _OnboardingOptionState();
}

class _OnboardingOptionState extends State<OnboardingOption> {
  @override
  Widget build(BuildContext context) {
    bool value = false;

    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged:
              (v) => setState(() {
                value = v!;
              }),
        ),
        Text(widget.text),
      ],
    );
  }
}

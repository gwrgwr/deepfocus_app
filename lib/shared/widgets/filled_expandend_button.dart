import 'package:flutter/material.dart';

class FilledExpandendButton extends StatelessWidget {
  FilledExpandendButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: TextStyle(letterSpacing: 2)),
    );
  }
}

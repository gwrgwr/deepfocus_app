import 'package:flutter/material.dart';

class MyLinearProgressIndicator extends StatelessWidget {
  const MyLinearProgressIndicator({required this.value, super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
  }
}

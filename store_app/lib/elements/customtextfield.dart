import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  // We require the controller and label, but make obscureText optional (defaulting to false)
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false, 
  });

  @override
  Widget build(BuildContext context) {
    final Color burgundy = const Color(0xFFFFFFFF);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: burgundy, width: 2),
        ),
      ),
    );
  }
}
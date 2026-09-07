import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;

  const CustomTextField({super.key, required this.label, required this.hint, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.white24),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFFA4A66)),
            ),
            suffixIcon: isPassword 
                ? const Icon(Icons.visibility_off, color: Colors.white54) 
                : null,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
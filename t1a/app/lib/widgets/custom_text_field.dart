import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Holds the obscure state locally without needing a StatefulWidget
    final ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(isPassword);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: obscureNotifier,
          builder: (context, isObscured, child) {
            return TextField(
              controller: controller,
              obscureText: isObscured,
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
                    ? IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white54,
                        ),
                        onPressed: () {
                          obscureNotifier.value = !obscureNotifier.value;
                        },
                      )
                    : null,
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
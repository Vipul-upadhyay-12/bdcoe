import 'package:flutter/material.dart';

class GoogleAuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const GoogleAuthButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Color(0xFFFA4A66),
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata, color: Colors.redAccent, size: 28),
                    SizedBox(width: 8),
                    Text(
                      "Google",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
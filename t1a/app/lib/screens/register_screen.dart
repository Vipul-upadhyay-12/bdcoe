import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../bar/head.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          CustomAuthHeader(
            title: "Register",
            subtitle: "Create your account",
            showBackButton: true,
            onBackTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: "Full Name",
                    hint: "Ferdinand Sinaga",
                  ),
                  const CustomTextField(
                    label: "Email",
                    hint: "Ferdinand@gmail.com",
                  ),
                  const CustomTextField(
                    label: "Password",
                    hint: "********",
                    isPassword: true,
                  ),
                  const CustomTextField(
                    label: "Repeat Password",
                    hint: "********",
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: "Register",
                    onPressed: () {},
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: RichText(
                        text: const TextSpan(
                          text: "I have account? ",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Log in",
                              style: TextStyle(
                                color: Color(0xFFFA4A66),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
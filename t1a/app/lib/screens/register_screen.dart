import 'package:app/bar/authmethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../bar/head.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  bool _isLoading = false;
  

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final repeatPassword = _repeatPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _isLoading = true);

    

    try {
      // Create user with Firebase Auth
      await registerUser(name: name, email: email, password: password);

      // Pop back to the root; Auth gatekeeper automatically loads HomeScreen
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context){
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
                  CustomTextField(
                    label: "Full Name",
                    hint: "Ferdinand Sinaga",
                    controller: _nameController,
                  ),
                  CustomTextField(
                    label: "Email",
                    hint: "Ferdinand@gmail.com",
                    controller: _emailController,
                  ),
                  CustomTextField(
                    label: "Password",
                    hint: "********",
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  CustomTextField(
                    label: "Repeat Password",
                    hint: "********",
                    controller: _repeatPasswordController,
                    isPassword: true,
                  ),
                  
                  
                  const SizedBox(height: 30),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFA4A66),
                          ),
                        )
                      : PrimaryButton(
                          text: "Register",
                          onPressed: _handleRegister,
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
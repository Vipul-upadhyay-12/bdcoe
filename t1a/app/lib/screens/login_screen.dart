import 'package:flutter/material.dart';
import 'package:app/bar/authmethods.dart';
import 'package:app/widgets/googleauth.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../bar/head.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both email and password")),
      );
      return;
    }

    setState(() => _isloading = true);

    try {
      await loginUser(
        email: email,
        password: password,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isloading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);

    try {
      await signInWithGoogle();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          const CustomAuthHeader(
            title: "Login",
            subtitle: "Sign in to Account",
            showBackButton: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(color: Color(0xFFFA4A66), fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _isloading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFA4A66),
                          ),
                        )
                      : PrimaryButton(text: "login", onPressed: _handleLogin),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Or login with",
                          style: TextStyle(color: Colors.white54, fontSize: 13),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          Icons.facebook,
                          "Facebook",
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GoogleAuthButton(
                          onTap: _handleGoogleSignIn,
                          isLoading: _isGoogleLoading,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have account? ",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Register",
                              style: TextStyle(color: Color(0xFFFA4A66), fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, Color iconColor) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}
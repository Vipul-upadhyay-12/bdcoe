import 'package:flutter/material.dart';
import 'package:store_app/elements/customtextfield.dart';
import 'auth_service.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  
  final Color burgundy = const Color.fromARGB(255, 230, 238, 238);

  void _register() async {
    final user = await _authService.registerWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (user == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration failed. Try a different email or stronger password.")),
      );
    } else if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text("Register", style: TextStyle(color: Colors.blue,)),
        backgroundColor: burgundy,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: "Email",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              labelText: "Password (min. 6 characters)",
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: burgundy,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _register,
              child: const Text("CREATE ACCOUNT", style: TextStyle(fontSize: 16, color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
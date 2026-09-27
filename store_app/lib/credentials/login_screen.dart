


import 'package:flutter/material.dart';
import 'package:store_app/credentials/auth_service.dart';
import 'package:store_app/credentials/register_screen.dart';
import 'package:store_app/elements/customtextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  //not using this colour ,final Color burgundy = const Color(0xFF800020);

  void _login() async {
    final user = await _authService.loginWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if(user == null && mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Failed, Check your credentials")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: const Text("Sign In", style: TextStyle(color: Colors.white)),
      //   backgroundColor: burgundy,
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // 2. The LinearGradient applies the top-to-bottom color fade
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5CE1E6), // Bright Cyan Top
              Color(0xFF3858D6), // Deep Blue Bottom
            ],
          ),
        ),
        
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical:  48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Login with your\nAccount",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 50,),
                CustomTextField(
                  controller: _emailController,
                  labelText: "example@gmail.com",
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _passwordController,
                  labelText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 48,),

                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF3858D6),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0, // Disable default elevation to use our custom glossy shadow above
                    ),
                    onPressed: _login,
                    child: const Text("Sign In", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 32),
                
                // "Or connect with" divider
                const Center(
                  child: Text(
                    "Or connect with",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Circular Google Button
                Center(
                  child: InkWell(
                    onTap: () {
                      _authService.signInWithGoogle();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          "G",
                          style: TextStyle(
                            color: Color(0xFF3858D6), 
                            fontSize: 24, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                //const SizedBox(height: 32),
                const SizedBox(height: 24,),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text("Don't have an account? Sign up"),
                ),
              ],

            ),
          ), 
        ),
      ),
    );
  }
}
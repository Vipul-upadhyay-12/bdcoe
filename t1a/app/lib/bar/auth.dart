import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/bar/authmethods.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<User?>(
        stream: authStateStream(),
        builder: (context, snapshot) {
          // 1. Waiting for Firebase to resolve initial auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFA4A66),
              ),
            );
          }

          // 2. User is authenticated
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // 3. User is not logged in
          return const LoginScreen();
        },
      ),
    );
  }
}
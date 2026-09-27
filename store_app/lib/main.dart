import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // This file was generated when you ran flutterfire configure
import 'credentials/auth_gate.dart'; 

void main() async {
  // Required to ensure the engine is ready before firing up Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase using the configuration for your specific platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App',
      debugShowCheckedModeBanner: false, // Removes the red debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF800020)),
        useMaterial3: true,
      ),
      // AuthGate replaces the default MyHomePage to control routing
      home: const AuthGate(), 
    );
  }
}
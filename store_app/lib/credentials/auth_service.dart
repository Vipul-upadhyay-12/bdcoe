

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  // to create a new account with a user defined email and password
  Future registerWithEmail( String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );

    } catch(e){
      print("Registration Error: $e");
      return null;
    }

  }

  // sign in an user with a available email and password;
  Future loginWithEmail (String email, String password) async{
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
    } catch(e){
      print("Login error: $e");
      return null;
    }
  }

  // log out the user
  Future logout() async {
    try {
      // 1. Sign out of standard Firebase Email Auth
      await FirebaseAuth.instance.signOut();
      
      // 2. Safely attempt to sign out of Google, ignoring web client errors
      try {
        await GoogleSignIn().signOut();
      } catch (e) {
        print("Skipping Google Sign-Out on web: $e");
      }
      
    } catch (e) {
      print("Firebase Logout Error: $e");
    }
  }

  // for google authenticatioon - future integration needed

  Future signInWithGoogle() async {
    try {
      // triggers google authentication flow
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null)return null;

      //obtains authentication details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // creates a new credentials
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,

      );

      //sign in to firebase with google credentials
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("google Sign in error : $e");
      return null;
    }
  }
}
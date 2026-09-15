import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn.standard(
  scopes: <String>['email'],
);
//stream
Stream<User?> authStateStream() => _auth.authStateChanges();

//register
Future<UserCredential> registerUser({
  required String name,
  required String email,
  required String password,
}) async {
  final credential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  await credential.user?.updateDisplayName(name);
  return credential;
}

//login
Future<UserCredential> loginUser({
  required String email,
  required String password,
}) async {
  return await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

// google sign in
Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await _auth.signInWithCredential(credential);
}
//logout
Future<void> logoutUser() async {
  await Future.wait([
    _auth.signOut(),
    _googleSignIn.signOut(),
  ]);
}


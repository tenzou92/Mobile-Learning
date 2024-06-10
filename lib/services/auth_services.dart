import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  // Google Sign In
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Ensure user is signed out before attempting to sign in again
    await googleSignIn.signOut();

    // Begin interactive sign-in process
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    // If user cancels the sign-in process
    if (gUser == null) {
      throw Exception('Sign in aborted by user');
    }

    // Obtain auth details from the request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create a new credential for the user
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Sign in with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

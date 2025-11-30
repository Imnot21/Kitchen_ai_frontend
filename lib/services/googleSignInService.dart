/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Use the default constructor for Android
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Sign in with Google
  Future<String?> signInWithGoogle() async {
    try {
      // Start the sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) return "Cancelled"; // user closed the pop-up

      // Retrieve the authentication tokens
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Make sure tokens are not null
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        return "Missing Google Auth tokens";
      }

      // Create a Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      await _auth.signInWithCredential(credential);

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e, stack) {
      print("SignIn error: $e\n$stack");
      return "Something went wrong: $e";
    }
  }

  // Sign out
  Future<void> googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  /// If [forSignUp] is true, attempts a silent sign-in first (for new users), else interactive sign-in.
  static Future<UserCredential?> signInWithGoogle({
    bool forSignUp = false,
  }) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleUser;
      if (forSignUp) {
        // Try silent sign-in (if user already signed in elsewhere)
        googleUser = await googleSignIn.signInSilently();
        // If not signed in, fall back to interactive
        googleUser ??= await googleSignIn.signIn();
      } else {
        googleUser = await googleSignIn.signIn();
      }
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Google Sign-In error: $e');
      return null;
    }
  }
}

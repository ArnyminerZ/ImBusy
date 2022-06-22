import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<UserCredential?> signInWithGoogle() async {
  if (kIsWeb) {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com' // TODO: Localize hint
    });

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  } else {
    // TODO: Handle mobile platforms
    return null;
  }
}

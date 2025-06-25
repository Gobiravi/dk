import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  static Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        debugPrint('🔴 Sign-in canceled by user');
        return null;
      }

      debugPrint('✅ Signed in as: ${account.displayName}');
      debugPrint('📧 Email: ${account.email}');
      debugPrint('🖼️ Avatar: ${account.photoUrl}');
      debugPrint('🆔 ID: ${account.id}');

      return account;
    } catch (e) {
      debugPrint('❌ Google Sign-In error: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    debugPrint('👋 Signed out of Google account');
  }
}

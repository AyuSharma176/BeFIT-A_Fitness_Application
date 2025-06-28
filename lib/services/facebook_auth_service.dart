// lib/services/facebook_auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final credential = FacebookAuthProvider.credential(result.accessToken!.token);
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } else {
      throw FirebaseAuthException(
        code: 'FACEBOOK_LOGIN_FAILED',
        message: result.message,
      );
    }
  }
}

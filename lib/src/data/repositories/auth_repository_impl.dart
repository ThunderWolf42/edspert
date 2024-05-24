import 'package:edspert/src/data/data_source/auth_data_source.dart';
import 'package:edspert/src/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<bool> IsRegisteredUsecase(String email) { // Corrected method name
    // Implementation goes here
    throw UnimplementedError();
  }

  @override
  Future<bool> RegisterUsecase() { // Corrected method name
    // Implementation goes here
    throw UnimplementedError();
  }

  @override
  bool IsSignedInWithGoogleUsecase() { // Corrected method name
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<String?> SignInWithGoogleUsecase() async { // Corrected method name
    // Existing implementation
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredentialResult = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredentialResult.user?.email;
    } catch (e) {
      debugPrint('Err signInWithGoogle $e');
      return null;
    }
  }
}
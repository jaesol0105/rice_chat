import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({
    required this.auth,
    required this.googleSignIn,
    required this.db,
  });
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore db;

  Future<User> signInWithGoogle() async {
    await googleSignIn.initialize();
    GoogleSignInAccount? googleUser;

    try {
      if (googleSignIn.supportsAuthenticate()) {
        googleUser = await googleSignIn.authenticate();
      } else {
        throw Exception("이 플랫폼은 authenticate()를 지원하지 않습니다.");
      }
    } catch (e) {
      throw Exception("cancelled");
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final result = await auth.signInWithCredential(credential);

    final user = result.user;

    if(user == null) throw Exception("Google sign-in failed");
    return user;
  }
  Future<void> createUpdateUser({
    required String uid,
    required String email,
    required String provider,
  }) async {
    await db.collection("users").doc(uid).set(
      {
        "email": email,
        "provider": provider,
        "updatedAt": FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn.instance,
    db: FirebaseFirestore.instance,
  );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({required this.auth, required this.googleSignIn, required this.db});

  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore db;

  Future<User> signInWithGoogle() async {
    await googleSignIn.initialize();

    // 계정 선택
    GoogleSignInAccount? googleUser;
    try {
      if (googleSignIn.supportsAuthenticate()) {
        googleUser = await googleSignIn.authenticate();
      } else {
        throw Exception("현재 플랫폼은 authenticate()를 지원하지 않습니다.");
      }
    } catch (e, st) {
      throw Exception("Google 계정 선택 실패: $e\n$st");
    }

    // 토큰 얻기
    GoogleSignInAuthentication googleAuth;
    try {
      googleAuth = await googleUser.authentication;
    } catch (e, st) {
      throw Exception("Google Authentication 토큰 획득 실패: $e\n$st");
    }

    // Firebase 로그인
    UserCredential result;
    try {
      final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);
      result = await auth.signInWithCredential(credential);
    } catch (e, st) {
      throw Exception("Firebase Google 로그인 실패: $e\n$st");
    }

    // 5. 유저 null 체크
    final user = result.user;
    if (user == null) {
      throw Exception("Firebase에서 user 객체가 Null로 반환됨");
    }

    return user;
  }

  Future<void> createUpdateUser({
    required String uid,
    required String email,
    required String provider,
  }) async {
    await db.collection("users").doc(uid).set({
      "email": email,
      "provider": provider,
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
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

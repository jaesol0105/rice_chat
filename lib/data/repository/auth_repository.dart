import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rice_chat/data/model/user_check_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({required this.auth, required this.googleSignIn, required this.db});

  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore db;

  /// 구글 계정 로그인
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

    // 유저 null 체크
    final user = result.user;
    if (user == null) {
      throw Exception("Firebase에서 user 객체가 Null로 반환됨");
    }

    return user;
  }

  /// 유저 생성
  Future<void> createUser({required String uid, required String provider}) async {
    await db.collection("users").doc(uid).set({"provider": provider}, SetOptions(merge: true));
  }

  /// 회원가입 진행 단계 체크
  Future<UserCheckStatus> checkUserStatus(String uid) async {
    final doc = await db.collection("users").doc(uid).get();
    // 유저 문서가 존재하지 않음
    if (!doc.exists) {
      return UserCheckStatus.noDocument;
    }
    final data = doc.data() ?? {};
    // 문서는 있지만 name 필드 없음 (회원가입 1단계 미완료)
    if (data['name'] == null) {
      return UserCheckStatus.missingName;
    }
    // name은 있지만 address 없음 (회원가입 2단계 미완료)
    if (data['address'] == null) {
      return UserCheckStatus.missingAddress;
    }
    // 모든 값이 있음 (회원가입이 된 계정)
    return UserCheckStatus.completed;
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

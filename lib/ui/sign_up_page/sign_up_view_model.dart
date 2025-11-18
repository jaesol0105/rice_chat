import 'package:firebase_auth/firebase_auth.dart';
import 'package:rice_chat/data/model/user_entity.dart';
import 'package:rice_chat/data/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_view_model.g.dart';

@riverpod
class SignUpViewModel extends _$SignUpViewModel{
  @override
  void build(){}

  String? validate({
    required String name,
    required String ageText,
    required String about,
  }){
    if(name.isEmpty)return "이름을 입력해주세요";
    if(ageText.isEmpty)return "나이를 입력해주세요";
    if(int.tryParse(ageText) == null)return "나이를 숫자로 입력해주세요";
    if (about.isEmpty) return "소개 멘트를 입력해주세요";
    return null;

  }

  Future<void> saveProfile({
    required String name,
    required int age,
    required bool sex,
    required String? address,
    required String? aboutMe,
  })async{
    final user = FirebaseAuth.instance.currentUser;
    if(user == null) throw Exception("로그인 정보 없음");

    final repo = ref.read(userRepositoryProvider);

    final entity = UserEntity(
      id: user.uid, 
      name: name, 
      age: age, 
      sex: sex, 
      address: address,
      aboutMe: aboutMe,
    );
    await repo.updateUser(entity);
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rice_chat/data/repository/user_repository.dart';
import 'package:rice_chat/data/repository/vworld_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_search_view_model.g.dart';

@riverpod
class AddressSearchViewModel extends _$AddressSearchViewModel {
  VworldRepository get repo => ref.read(vworldRepositoryProvider);

  @override
  Future<List<String>> build() async {
    return [];
  }

  void searchByName(String query) async {
    final result = await repo.findByName(query);
    state = AsyncValue.data(result);
  }

  void serachByLocation(double lat, double lng) async {
    final result = await repo.findByLatLng(lat, lng);
    state = AsyncValue.data(result);
  }

  /// 파이어베이스 문서 갱신
  Future<void> saveAddress({required String address}) async {
    final user = FirebaseAuth.instance.currentUser; // 나중에 authVM에서 상태 값으로 관리하도록 변경
    if (user == null) throw Exception("로그인 정보 없음");

    final repo = ref.read(userRepositoryProvider);

    await repo.updateUserAddress(uid: user.uid, address: address);
  }
}

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
}
